import 'dart:io';

class FileCleaner {
  static Future<void> cleanCommentsFromFile(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        print('Warning: File $filePath does not exist');
        return;
      }

      final content = await file.readAsString();
      final cleanedContent = _removeComments(content);
      await file.writeAsString(cleanedContent);
    } catch (e) {
      print('Error cleaning file $filePath: $e');
    }
  }

  static String _removeComments(String content) {
    // Remove YAML comments (lines starting with #)
    if (content.contains('pubspec.yaml')) {
      return content.split('\n').where((line) => !line.trim().startsWith('#')).join('\n');
    }

    // Remove Dart comments (// and /* */)
    if (content.contains('.dart')) {
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
}
