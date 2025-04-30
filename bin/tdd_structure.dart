import 'dart:io';

import 'package:args/args.dart';
import 'package:tdd_structure/structure_create.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('name', abbr: 'n', help: 'The name of the structure')
    ..addOption('feature', abbr: 'f', help: 'The name of the feature to generate')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage information');

  var argResults = parser.parse(arguments);

  if (argResults['help']) {
    print('Usage:');
    print('  Generate core structure: tdd_structure --name <structure_name>');
    print('  Generate feature: tdd_structure --feature <feature_name>');
    print(parser.usage);
    exit(0);
  }

  if (!Directory('lib').existsSync()) {
    print('Error: You must run this tool in the root of a Flutter project.');
    exit(1);
  }

  if (argResults['feature'] != null) {
    var featureName = argResults['feature'];
    addFeatureStructure(featureName);
  } else {
    var projectName = argResults['name'] ?? 'default_structure';
    addCustomStructure(projectName);
  }
}
