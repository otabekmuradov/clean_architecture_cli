import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

import 'folder_create.dart';

void addCustomStructure() async {
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

/* =========================== CREATE CORE AND FEATURE ========================================*/
  createDirectoryAndFile('lib/core');
  createDirectoryAndFile('lib/core/services');
  createDirectoryAndFile('lib/core/enums');
  createDirectoryAndFile('lib/core/constants');
  createDirectoryAndFile('lib/core/bloc');
  createDirectoryAndFile('lib/core/di');
  createDirectoryAndFile('lib/core/errors');
  createDirectoryAndFile('lib/core/extensions');
  createDirectoryAndFile('lib/core/observers');
  createDirectoryAndFile('lib/core/routes');
  createDirectoryAndFile('lib/core/themes');
  createDirectoryAndFile('lib/core/usecases');

  // Remove features directory creation from here
  // createDirectoryAndFile('lib/features');

/* =========================== BLOC FILES CREATE ========================================*/

  createFile(
    'lib/core/bloc/bloc_scope.dart',
    content: await readContentFromFile('$packagePath/lib/content/bloc_scope.txt'),
  );

  createFile(
    'lib/core/bloc/bloc_observer.dart',
    content: await readContentFromFile('$packagePath/lib/content/bloc_observer.txt'),
  );

  /* ============================= CONSTANTS FILE CREATE ========================================*/

  createFile(
    'lib/core/constants/constatns.dart',
    content: await readContentFromFile('$packagePath/lib/content/constants.txt'),
  );


  /* =========================== ROUTES FILES CREATE ========================================*/

  createFile(
    'lib/core/routes/app_router.dart',
    content: await readContentFromFile('$packagePath/lib/content/app_router.txt'),
  );

  createFile(
    'lib/core/routes/navigation_observer.dart',
    content: await readContentFromFile('$packagePath/lib/content/navigation_observer.txt'),
  );

  /* ============================= DI FILE CREATE ========================================*/

  createFile(
    'lib/core/di/service_locator.dart',
    content: await readContentFromFile('$packagePath/lib/content/di.txt'),
  );

  /* ============================= ERRORS FILE CREATE ========================================*/

  createFile(
    'lib/core/errors/exeptions.dart',
    content: await readContentFromFile('$packagePath/lib/content/exeptions.txt'),
  );

  createFile(
    'lib/core/errors/failure.dart',
    content: await readContentFromFile('$packagePath/lib/content/failure.txt'),
  );

  /* =========================== EXTENSION FILE CREATE ========================================*/

  createFile(
    'lib/core/extensions/extension.dart',
    content: await readContentFromFile('$packagePath/lib/content/extension.txt'),
  );

  /* ============================= ENUMS FILE CREATE ========================================*/

  createFile(
    'lib/core/enums/enums.dart',
    content: await readContentFromFile('$packagePath/lib/content/enums.txt'),
  );

/* =========================== USECASE FILE CREATE ========================================*/

  createFile(
    'lib/core/usecases/usecase.dart',
    content: await readContentFromFile('$packagePath/lib/content/usecase.txt'),
  );

/* ============================= THEMES FILE CREATE ========================================*/

  createFile(
    'lib/core/themes/app_diemens.dart',
    content: await readContentFromFile('$packagePath/lib/content/app_diemens.txt'),
  );

  createFile(
    'lib/core/themes/app_colors.dart',
    content: await readContentFromFile('$packagePath/lib/content/app_colors.txt'),
  );
  createFile(
    'lib/core/themes/app_fonts.dart',
    content: await readContentFromFile('$packagePath/lib/content/app_fonts.txt'),
  );

  createFile(
    'lib/core/themes/app_theme.dart',
    content: await readContentFromFile('$packagePath/lib/content/app_theme.txt'),
  );
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
