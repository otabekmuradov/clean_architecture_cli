import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class FileCleaner {
  static Future<void> cleanCommentsFromFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        print('Warning: File $filePath does not exist');
        return;
      }

      final content = await file.readAsString();
      final cleanedContent = _removeComments(content, filePath);
      await file.writeAsString(cleanedContent);
    } catch (e) {
      print('Error cleaning file $filePath: $e');
    }
  }

  static String _removeComments(String content, String filePath) {
    // Remove YAML comments (lines starting with #)
    if (filePath.endsWith('pubspec.yaml')) {
      return content.split('\n').where((line) {
        // Keep lines that are not comments
        final trimmedLine = line.trim();
        return !trimmedLine.startsWith('#') && trimmedLine.isNotEmpty;
      }).join('\n');
    }

    // Remove Dart comments (// and /* */)
    if (filePath.endsWith('.dart')) {
      // Remove single line comments
      var result = content.replaceAll(RegExp(r'//.*$', multiLine: true), '');

      // Remove multi-line comments
      result = result.replaceAll(RegExp(r'/\*[\s\S]*?\*/'), '');

      // Remove empty lines
      result = result.split('\n').where((line) => line.trim().isNotEmpty).join('\n');

      return result;
    }

    return content;
  }

  static Future<void> cleanProjectFiles() async {
    // Clean pubspec.yaml
    await cleanCommentsFromFile('pubspec.yaml');

    // Clean main.dart if it exists
    final mainDartPath = 'lib/main.dart';
    if (await File(mainDartPath).exists()) {
      await cleanCommentsFromFile(mainDartPath);
    }
  }

  static Future<void> updatePackageInfo() async {
    try {
      final pubspecFile = File('pubspec.yaml');
      if (!await pubspecFile.exists()) {
        print('Error: pubspec.yaml not found');
        return;
      }

      final content = await pubspecFile.readAsString();
      final dependencies = _extractDependencies(content);

      if (dependencies.isEmpty) {
        print('No dependencies found in pubspec.yaml');
        return;
      }

      final packageInfo = await _fetchPackageInfo(dependencies);
      await _updateContentFiles(packageInfo);

      print('Package information updated successfully!');
    } catch (e) {
      print('Error updating package info: $e');
    }
  }

  static List<String> _extractDependencies(String content) {
    final dependencies = <String>[];
    final lines = content.split('\n');
    var inDependencies = false;

    for (final line in lines) {
      final trimmedLine = line.trim();

      if (trimmedLine == 'dependencies:') {
        inDependencies = true;
        continue;
      }

      if (inDependencies && trimmedLine.isNotEmpty && !trimmedLine.startsWith('  ')) {
        inDependencies = false;
        continue;
      }

      if (inDependencies && trimmedLine.isNotEmpty) {
        final packageName = trimmedLine.split(':')[0].trim();
        if (packageName.isNotEmpty) {
          dependencies.add(packageName);
        }
      }
    }

    return dependencies;
  }

  static Future<Map<String, String>> _fetchPackageInfo(List<String> packages) async {
    final packageInfo = <String, String>{};

    for (final package in packages) {
      try {
        final response = await http.get(
          Uri.parse('https://pub.dev/api/packages/$package'),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final latestVersion = data['latest']['version'] as String;
          final description = data['latest']['pubspec']['description'] as String? ?? 'No description available';

          packageInfo[package] = '''
Package: $package
Version: $latestVersion
Description: $description
''';
        }
      } catch (e) {
        print('Error fetching info for $package: $e');
      }
    }

    return packageInfo;
  }

  static Future<void> _updateContentFiles(Map<String, String> packageInfo) async {
    final contentDir = Directory('lib/content');
    if (!await contentDir.exists()) {
      await contentDir.create(recursive: true);
    }

    final packagesFile = File('lib/content/packages.txt');
    final content = packageInfo.values.join('\n---\n');
    await packagesFile.writeAsString(content);
  }
}
