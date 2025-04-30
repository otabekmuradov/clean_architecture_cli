import 'dart:io';

import 'package:args/args.dart';
import 'package:tdd_structure/structure_create.dart';

void main(List<String> arguments) {
  final parser = ArgParser();

  // Add commands
  final createCommand = ArgParser();
  final featureCommand = ArgParser()..addOption('name', abbr: 'n', help: 'Feature name', mandatory: true);

  parser
    ..addCommand('create', createCommand)
    ..addCommand('feature', featureCommand)
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
    } else if (argResults.command!.name == 'feature') {
      var featureName = argResults.command!['name'];
      addFeatureStructure(featureName);
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    _showHelp(parser);
    exit(1);
  }
}

void _showHelp(ArgParser parser) {
  print('''
TDD Structure Generator

A CLI tool for generating TDD-compliant Flutter project structures.

USAGE:
  tdd_structure <COMMAND> [ARGS]

COMMANDS:
  create                    Create a new project structure
  feature --name <feature>  Generate a new feature
  help                     Show this help message

EXAMPLES:
  Create a new project:
    tdd_structure create

  Generate a feature:
    tdd_structure feature --name user_auth
    tdd_structure feature -n user_auth

  Show help:
    tdd_structure help
    tdd_structure --help
    tdd_structure -h
''');
}
