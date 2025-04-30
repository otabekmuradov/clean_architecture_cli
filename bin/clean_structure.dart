import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:clean_structure/file_cleaner.dart';
import 'package:clean_structure/structure_create.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  final parser = ArgParser();

  // Add commands
  final createCommand = ArgParser();
  final featureCommand = ArgParser()..addOption('name', abbr: 'n', help: 'Feature name', mandatory: true);
  final templateCommand = ArgParser();
  final packagesCommand = ArgParser();

  parser
    ..addCommand('create', createCommand)
    ..addCommand('feature', featureCommand)
    ..addCommand('template', templateCommand)
    ..addCommand('packages', packagesCommand)
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show this help message');

  try {
    var argResults = parser.parse(arguments);

    if (argResults['help'] || arguments.isEmpty) {
      _showHelp(parser);
      exit(0);
    }

    if (!Directory('lib').existsSync()) {
      print('Error: You must run this tool in the root of a Flutter project.');
      exit(1);
    }

    if (argResults.command == null) {
      _showHelp(parser);
      exit(1);
    }

    if (argResults.command!.name == 'create') {
      addCustomStructure('default_structure');
      print('\nCleaning project files...');
      await FileCleaner.cleanProjectFiles();
      print('Project files cleaned successfully!');
    } else if (argResults.command!.name == 'feature') {
      var featureName = argResults.command!['name'];
      addFeatureStructure(featureName);
    } else if (argResults.command!.name == 'template') {
      await _downloadTemplate();
    } else if (argResults.command!.name == 'packages') {
      print('Updating package information...');
      await FileCleaner.updatePackageInfo();
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    _showHelp(parser);
    exit(1);
  }
}

Future<void> _downloadTemplate() async {
  try {
    final packageUri = await Isolate.resolvePackageUri(Uri.parse('package:clean_structure/'));
    if (packageUri == null) {
      print('Error: Unable to resolve package URI.');
      exit(1);
    }

    final packagePath = p.dirname(packageUri.toFilePath());
    final templatePath = p.join(packagePath, 'lib', 'content', 'template.md');

    if (!File(templatePath).existsSync()) {
      print('Error: Template file not found.');
      exit(1);
    }

    final templateContent = await File(templatePath).readAsString();
    await File('template.md').writeAsString(templateContent);

    print('Template file downloaded successfully to project root!');
  } catch (e) {
    print('Error downloading template: $e');
    exit(1);
  }
}

void _showHelp(ArgParser parser) {
  print('''
Clean Structure Generator

A CLI tool for generating clean architecture Flutter project structures.

INSTALLATION:
  Activate:
    dart pub global activate clean_structure

  Deactivate:
    dart pub global deactivate clean_structure

USAGE:
  clean_structure <COMMAND> [ARGS]

COMMANDS:
  create                    Create a new project structure (also cleans comments from pubspec.yaml and main.dart)
  feature --name <feature>  Generate a new feature
  template                 Download the clean architecture template to project root
  packages                 Update package information from pub.dev
  help                     Show this help message

EXAMPLES:
  Create a new project:
    clean_structure create

  Generate a feature:
    clean_structure feature --name user_auth
    clean_structure feature -n user_auth

  Download template:
    clean_structure template

  Update package info:
    clean_structure packages

  Show help:
    clean_structure help
    clean_structure --help
    clean_structure -h
''');
}
