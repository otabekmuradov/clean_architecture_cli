import 'dart:io';

import 'package:args/args.dart';
import '../lib/structure_create.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('name', abbr: 'n', help: 'The name of the structure')
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage information');

  var argResults = parser.parse(arguments);

  if (argResults['help']) {
    print('Usage: folder_structure --name <structure_name>');
    print('Usage: folder_structure --feature <structure_name>');

    print(parser.usage);
    exit(0);
  }

  var projectName = argResults['name'] ?? 'default_structure';

  if (!Directory('lib').existsSync()) {
    print('Error: You must run this tool in the root of a Flutter project.');
    exit(1);
  }

  addCustomStructure(projectName);
}
