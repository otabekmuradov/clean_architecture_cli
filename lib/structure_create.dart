import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

import 'folder_create.dart';

void addCustomStructure(String projectName) async {
  final packageUri = await Isolate.resolvePackageUri(Uri.parse('package:clean_structure/'));
  if (packageUri == null) {
    print('Error: Unable to resolve package URI.');
    exit(1);
  }

  print('Adding custom structure to the project');

  final currentDir = Directory.current.path;

  if (!Directory(p.join(currentDir, 'lib')).existsSync()) {
    print('Error: lib folder in project not found.');
    exit(1);
  }

  // Get the package path from the resolved URI
  final packagePath = p.dirname(packageUri.toFilePath());

  if (!Directory(packagePath).existsSync()) {
    print('Error: Package directory not found at $packagePath');
    print('Please make sure the package is properly installed.');
    exit(1);
  }

  log('Package path: $packagePath');
}

void addFeatureStructure(String featureName) {
  print('Adding feature structure: $featureName');

  // Create features directory if it doesn't exist
  createDirectoryAndFile('lib/features');

  // Create main feature directory
  createDirectoryAndFile('lib/features/$featureName');

  // Create data layer
  createDirectoryAndFile('lib/features/$featureName/data');

  // Create data sources
  createDirectoryAndFile('lib/features/$featureName/data/data_sources');
  createDirectoryAndFile('lib/features/$featureName/data/data_sources/local_datasource');
  createDirectoryAndFile('lib/features/$featureName/data/data_sources/remote_datasource');

  // Create data source files
  createFile(
    'lib/features/$featureName/data/data_sources/local_datasource/${featureName}_local_datasource.dart',
    content: '''
import 'package:clean_structure/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

class ${featureName.pascalCase}LocalDataSource {
  // Add your local data source implementation here
}
''',
  );

  createFile(
    'lib/features/$featureName/data/data_sources/remote_datasource/${featureName}_remote_datasource.dart',
    content: '''
import 'package:clean_structure/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ${featureName.pascalCase}RemoteDataSource {
  // Add your remote data source interface here
}

class ${featureName.pascalCase}RemoteDataSourceImpl implements ${featureName.pascalCase}RemoteDataSource {
  // Add your remote data source implementation here
}
''',
  );

  // Create models directory (empty as per requirements)
  createDirectoryAndFile('lib/features/$featureName/data/models');

  // Create repositories
  createDirectoryAndFile('lib/features/$featureName/data/repositories');
  createFile(
    'lib/features/$featureName/data/repositories/${featureName}_repository_impl.dart',
    content: '''
import 'package:clean_structure/core/errors/failure.dart';
import 'package:clean_structure/features/$featureName/domain/repositories/${featureName}_repository.dart';
import 'package:dartz/dartz.dart';

class ${featureName.pascalCase}RepositoryImpl implements ${featureName.pascalCase}Repository {
  // Add your repository implementation here
}
''',
  );

  // Create domain layer
  createDirectoryAndFile('lib/features/$featureName/domain');

  // Create entities directory (empty as per requirements)
  createDirectoryAndFile('lib/features/$featureName/domain/entities');

  // Create repositories
  createDirectoryAndFile('lib/features/$featureName/domain/repositories');
  createFile(
    'lib/features/$featureName/domain/repositories/${featureName}_repository.dart',
    content: '''
import 'package:clean_structure/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ${featureName.pascalCase}Repository {
  // Add your repository interface here
}
''',
  );

  // Create usecases directory (empty as per requirements)
  createDirectoryAndFile('lib/features/$featureName/domain/usecases');

  // Create presentation layer
  createDirectoryAndFile('lib/features/$featureName/presentation');

  // Create bloc
  createDirectoryAndFile('lib/features/$featureName/presentation/bloc');
  createFile(
    'lib/features/$featureName/presentation/bloc/${featureName}_bloc.dart',
    content: '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${featureName}_event.dart';
import '${featureName}_state.dart';

class ${featureName.pascalCase}Bloc extends Bloc<${featureName.pascalCase}Event, ${featureName.pascalCase}State> {
  ${featureName.pascalCase}Bloc() : super(${featureName.pascalCase}Initial()) {
    // Add your event handlers here
  }
}
''',
  );

  createFile(
    'lib/features/$featureName/presentation/bloc/${featureName}_event.dart',
    content: '''
part of '${featureName}_bloc.dart';

abstract class ${featureName.pascalCase}Event {}

// Add your events here
class Example${featureName.pascalCase}Event extends ${featureName.pascalCase}Event {}
''',
  );

  createFile(
    'lib/features/$featureName/presentation/bloc/${featureName}_state.dart',
    content: '''
part of '${featureName}_bloc.dart';

abstract class ${featureName.pascalCase}State {}

class ${featureName.pascalCase}Initial extends ${featureName.pascalCase}State {}
// Add your states here
''',
  );

  // Create screens
  createDirectoryAndFile('lib/features/$featureName/presentation/screens');
  createFile(
    'lib/features/$featureName/presentation/screens/${featureName}_screen.dart',
    content: '''
import 'package:flutter/material.dart';
import '../bloc/${featureName}_bloc.dart';

class ${featureName.pascalCase}Screen extends StatelessWidget {
  const ${featureName.pascalCase}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<${featureName.pascalCase}Bloc, ${featureName.pascalCase}State>(
        builder: (context, state) {
          return const Center(
            child: Text('${featureName.pascalCase} Screen'),
          );
        },
      ),
    );
  }
}
''',
  );

  // Create widgets directory (empty as per requirements)
  createDirectoryAndFile('lib/features/$featureName/presentation/widgets');

  print('Feature structure created successfully!');
}

// Extension to convert string to PascalCase
extension StringExtension on String {
  String get pascalCase {
    if (isEmpty) return this;
    return split('_')
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '')
        .join();
  }
}
