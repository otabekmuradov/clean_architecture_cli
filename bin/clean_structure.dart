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
  final templateCommand = ArgParser()
    ..addOption('type', abbr: 't', help: 'Architecture type (feature or layer)', mandatory: true);
  final layerCommand = ArgParser()..addOption('name', abbr: 'n', help: 'Layer name', mandatory: true);

  parser
    ..addCommand('create', createCommand)
    ..addCommand('feature', featureCommand)
    ..addCommand('template', templateCommand)
    ..addCommand('layer', layerCommand)
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
      addCustomStructure();
      print('\nCleaning project files...');
      await FileCleaner.cleanProjectFiles();
      print('Project files cleaned successfully!');
    } else if (argResults.command!.name == 'feature') {
      var featureName = argResults.command!['name'];
      addFeatureStructure(featureName);
    } else if (argResults.command!.name == 'template') {
      var type = argResults.command!['type'];
      if (type == 'feature') {
        await _downloadTemplate('feature');
        print('\nFeature-driven architecture template downloaded successfully!');
      } else if (type == 'layer') {
        await _downloadTemplate('layer');
        print('\nLayer-driven architecture template downloaded successfully!');
      } else {
        print('Error: Invalid architecture type. Use either "feature" or "layer".');
        exit(1);
      }
    } else if (argResults.command!.name == 'layer') {
      var layerName = argResults.command!['name'];
      print('Creating layer-driven architecture for $layerName...');
      await _createLayerStructure(layerName);
      print('Layer-driven architecture created successfully!');
    }
  } catch (e) {
    print('Error: ${e.toString()}');
    _showHelp(parser);
    exit(1);
  }
}

Future<void> _downloadTemplate(String type) async {
  try {
    final packageUri = await Isolate.resolvePackageUri(Uri.parse('package:clean_structure/'));
    if (packageUri == null) {
      print('Error: Unable to resolve package URI.');
      exit(1);
    }

    final packagePath = p.dirname(packageUri.toFilePath());
    final templatePath = p.join(packagePath, 'lib', 'content', '${type}_template.md');

    if (!File(templatePath).existsSync()) {
      print('Error: Template file not found.');
      exit(1);
    }

    final templateContent = await File(templatePath).readAsString();
    await File('${type}_architecture_template.md').writeAsString(templateContent);

    print('Template file downloaded successfully to project root!');
  } catch (e) {
    print('Error downloading template: $e');
    exit(1);
  }
}

Future<void> _createLayerStructure(String name) async {
  // Create main layers
  final layers = ['data', 'domain', 'presentation'];
  for (final layer in layers) {
    final layerDir = Directory('lib/$layer');
    if (!await layerDir.exists()) {
      await layerDir.create(recursive: true);
    }

    // Create structure for each layer
    switch (layer) {
      case 'data':
        await _createDataLayer(layerDir, name);
        break;
      case 'domain':
        await _createDomainLayer(layerDir, name);
        break;
      case 'presentation':
        await _createPresentationLayer(layerDir, name);
        break;
    }
  }
}

Future<void> _createDataLayer(Directory dir, String name) async {
  // Create datasources
  final datasourcesDir = Directory('${dir.path}/datasources');
  if (!await datasourcesDir.exists()) {
    await datasourcesDir.create(recursive: true);
  }

  // Create local and remote datasource folders
  final localDataSourceDir = Directory('${datasourcesDir.path}/local_datasources/${name}_local_datasource');
  final remoteDataSourceDir = Directory('${datasourcesDir.path}/remote_datasources/${name}_remote_datasource');

  await localDataSourceDir.create(recursive: true);
  await remoteDataSourceDir.create(recursive: true);

  // Create local datasource file
  final localDataSource = File('${localDataSourceDir.path}/${name}_local_data_source.dart');
  await localDataSource.writeAsString('''
import 'package:dartz/dartz.dart';
import 'package:${p.basename(Directory.current.path)}/core/errors/failure.dart';

abstract class ${_capitalize(name)}LocalDataSource {
  Future<Either<Failure, dynamic>> getData();
  Future<Either<Failure, void>> saveData(dynamic data);
}
''');

  // Create remote datasource file
  final remoteDataSource = File('${remoteDataSourceDir.path}/${name}_remote_data_source.dart');
  await remoteDataSource.writeAsString('''
import 'package:dartz/dartz.dart';
import 'package:${p.basename(Directory.current.path)}/core/errors/failure.dart';

abstract class ${_capitalize(name)}RemoteDataSource {
  Future<Either<Failure, dynamic>> getData();
  Future<Either<Failure, void>> saveData(dynamic data);
}
''');

  // Create models folder and file
  final modelsDir = Directory('${dir.path}/models/${name}_model');
  await modelsDir.create(recursive: true);

  final modelFile = File('${modelsDir.path}/${name}_model.dart');
  await modelFile.writeAsString('''
class ${_capitalize(name)}Model {
  // Add your model properties here
}
''');

  // Create repository implementation folder and file
  final repositoriesDir = Directory('${dir.path}/repositories/${name}_repository_impl');
  await repositoriesDir.create(recursive: true);

  final repositoryImplFile = File('${repositoriesDir.path}/${name}_repository_impl.dart');
  await repositoryImplFile.writeAsString('''
import 'package:dartz/dartz.dart';
import 'package:${p.basename(Directory.current.path)}/core/errors/failure.dart';
import 'package:${p.basename(Directory.current.path)}/domain/repositories/${name}_repository/${name}_repository.dart';
import 'package:${p.basename(Directory.current.path)}/data/datasources/local_datasources/${name}_local_datasource/${name}_local_data_source.dart';
import 'package:${p.basename(Directory.current.path)}/data/datasources/remote_datasources/${name}_remote_datasource/${name}_remote_data_source.dart';

class ${_capitalize(name)}RepositoryImpl implements ${_capitalize(name)}Repository {
  final ${_capitalize(name)}LocalDataSource localDataSource;
  final ${_capitalize(name)}RemoteDataSource remoteDataSource;

  ${_capitalize(name)}RepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, dynamic>> getData() async {
    // Implementation
  }

  @override
  Future<Either<Failure, void>> saveData(dynamic data) async {
    // Implementation
  }
}
''');
}

Future<void> _createDomainLayer(Directory dir, String name) async {
  // Create entities folder and file
  final entitiesDir = Directory('${dir.path}/entities/${name}_entity');
  await entitiesDir.create(recursive: true);

  final entityFile = File('${entitiesDir.path}/${name}_entity.dart');
  await entityFile.writeAsString('''
class ${_capitalize(name)}Entity {
  // Add your entity properties here
}
''');

  // Create repository interface folder and file
  final repositoriesDir = Directory('${dir.path}/repositories/${name}_repository');
  await repositoriesDir.create(recursive: true);

  final repositoryFile = File('${repositoriesDir.path}/${name}_repository.dart');
  await repositoryFile.writeAsString('''
import 'package:dartz/dartz.dart';
import 'package:${p.basename(Directory.current.path)}/core/errors/failure.dart';

abstract class ${_capitalize(name)}Repository {
  Future<Either<Failure, dynamic>> getData();
  Future<Either<Failure, void>> saveData(dynamic data);
}
''');

  // Create usecases folder and file
  final usecasesDir = Directory('${dir.path}/usecases/${name}_usecases');
  await usecasesDir.create(recursive: true);

  final getDataUsecaseFile = File('${usecasesDir.path}/get_${name}_data_usecase.dart');
  await getDataUsecaseFile.writeAsString('''
import 'package:dartz/dartz.dart';
import 'package:${p.basename(Directory.current.path)}/core/errors/failure.dart';
import 'package:${p.basename(Directory.current.path)}/domain/repositories/${name}_repository/${name}_repository.dart';

class Get${_capitalize(name)}DataUseCase {
  final ${_capitalize(name)}Repository repository;

  Get${_capitalize(name)}DataUseCase(this.repository);

  Future<Either<Failure, dynamic>> call() async {
    return await repository.getData();
  }
}
''');
}

Future<void> _createPresentationLayer(Directory dir, String name) async {
  // Create bloc folder and files
  final blocsDir = Directory('${dir.path}/blocs/${name}_bloc');
  await blocsDir.create(recursive: true);

  final blocFile = File('${blocsDir.path}/${name}_bloc.dart');
  await blocFile.writeAsString('''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${p.basename(Directory.current.path)}/domain/usecases/${name}_usecases/get_${name}_data_usecase.dart';

part '${name}_event.dart';
part '${name}_state.dart';

class ${_capitalize(name)}Bloc extends Bloc<${_capitalize(name)}Event, ${_capitalize(name)}State> {
  final Get${_capitalize(name)}DataUseCase getDataUseCase;

  ${_capitalize(name)}Bloc({required this.getDataUseCase}) : super(${_capitalize(name)}Initial()) {
    on<Get${_capitalize(name)}DataEvent>(_onGetData);
  }

  Future<void> _onGetData(
    Get${_capitalize(name)}DataEvent event,
    Emitter<${_capitalize(name)}State> emit,
  ) async {
    emit(${_capitalize(name)}Loading());
    final result = await getDataUseCase();
    result.fold(
      (failure) => emit(${_capitalize(name)}Error(failure.message)),
      (data) => emit(${_capitalize(name)}Loaded(data)),
    );
  }
}
''');

  final blocEventFile = File('${blocsDir.path}/${name}_event.dart');
  await blocEventFile.writeAsString('''
part of '${name}_bloc.dart';

abstract class ${_capitalize(name)}Event {}

class Get${_capitalize(name)}DataEvent extends ${_capitalize(name)}Event {}
''');

  final blocStateFile = File('${blocsDir.path}/${name}_state.dart');
  await blocStateFile.writeAsString('''
part of '${name}_bloc.dart';

abstract class ${_capitalize(name)}State {}

class ${_capitalize(name)}Initial extends ${_capitalize(name)}State {}

class ${_capitalize(name)}Loading extends ${_capitalize(name)}State {}

class ${_capitalize(name)}Loaded extends ${_capitalize(name)}State {
  final dynamic data;
  ${_capitalize(name)}Loaded(this.data);
}

class ${_capitalize(name)}Error extends ${_capitalize(name)}State {
  final String message;
  ${_capitalize(name)}Error(this.message);
}
''');

  // Create pages folder and file
  final pagesDir = Directory('${dir.path}/pages/${name}_page');
  await pagesDir.create(recursive: true);

  final pageFile = File('${pagesDir.path}/${name}_page.dart');
  await pageFile.writeAsString('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:${p.basename(Directory.current.path)}/presentation/blocs/${name}_bloc/${name}_bloc.dart';

class ${_capitalize(name)}Page extends StatelessWidget {
  const ${_capitalize(name)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ${_capitalize(name)}Bloc(
        getDataUseCase: context.read<Get${_capitalize(name)}DataUseCase>(),
      ),
      child: const ${_capitalize(name)}View(),
    );
  }
}

class ${_capitalize(name)}View extends StatelessWidget {
  const ${_capitalize(name)}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${_capitalize(name)}'),
      ),
      body: BlocBuilder<${_capitalize(name)}Bloc, ${_capitalize(name)}State>(
        builder: (context, state) {
          if (state is ${_capitalize(name)}Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ${_capitalize(name)}Error) {
            return Center(child: Text(state.message));
          }
          if (state is ${_capitalize(name)}Loaded) {
            return Center(child: Text('Data: \${state.data}'));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
''');
}

String _capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
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
  feature --name <feature>  Generate a new feature (feature-driven architecture)
  layer --name <name>      Generate layer-driven architecture structure with specific name
  template --type <type>   Create a template with specific architecture type (feature or layer)
  help                     Show this help message

EXAMPLES:
  Create a new project:
    clean_structure create

  Generate a feature (feature-driven):
    clean_structure feature --name user_auth
    clean_structure feature -n user_auth

  Generate layer-driven architecture:
    clean_structure layer --name home
    clean_structure layer -n home

  Create template with specific architecture:
    clean_structure template --type feature
    clean_structure template -t feature
    clean_structure template --type layer
    clean_structure template -t layer

  Show help:
    clean_structure help
    clean_structure --help
    clean_structure -h
''');
}
