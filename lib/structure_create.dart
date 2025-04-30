import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;

import 'folder_create.dart';

void addCustomStructure(String projectName) async {
  final packageUri = await Isolate.resolvePackageUri(Uri.parse('package:tdd_structure/'));
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
  createDirectoryAndFile('lib/core/widgets');
  createDirectoryAndFile('lib/core/enums');
  createDirectoryAndFile('lib/core/constants');
  createDirectoryAndFile('lib/core/bloc');
  createDirectoryAndFile('lib/core/config');
  createDirectoryAndFile('lib/core/di');
  createDirectoryAndFile('lib/core/errors');
  createDirectoryAndFile('lib/core/extensions');
  createDirectoryAndFile('lib/core/observers');
  createDirectoryAndFile('lib/core/routes');
  createDirectoryAndFile('lib/core/themes');
  createDirectoryAndFile('lib/core/usecases');
  createDirectoryAndFile('lib/core/utils');

  createDirectoryAndFile('lib/features');

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

  /* =========================== CONFIG FILES CREATE ========================================*/

  createFile(
    'lib/core/config/local_config.dart',
    content: await readContentFromFile('$packagePath/lib//content/local_config.txt'),
  );

  createFile(
    'lib/core/config/network_config.dart',
    content: await readContentFromFile('$packagePath/lib/content/network_config.txt'),
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

/* ============================= UTILS FILE CREATE ========================================*/

  createFile(
    'lib/core/utils/validators.dart',
    content: await readContentFromFile('$packagePath/lib/content/validator.txt'),
  );
  createFile(
    'lib/core/utils/formatters.dart',
    content: await readContentFromFile('$packagePath/lib/content/formatters.txt'),
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

  // Create main feature directory
  createDirectoryAndFile('lib/features/$featureName');

  // Create data layer
  createDirectoryAndFile('lib/features/$featureName/data');
  createDirectoryAndFile('lib/features/$featureName/data/data_sources');
  createDirectoryAndFile('lib/features/$featureName/data/models');
  createDirectoryAndFile('lib/features/$featureName/data/repositories');

  // Create domain layer
  createDirectoryAndFile('lib/features/$featureName/domain');
  createDirectoryAndFile('lib/features/$featureName/domain/entities');
  createDirectoryAndFile('lib/features/$featureName/domain/repositories');
  createDirectoryAndFile('lib/features/$featureName/domain/usecases');

  // Create presentation layer
  createDirectoryAndFile('lib/features/$featureName/presentation');
  createDirectoryAndFile('lib/features/$featureName/presentation/bloc');
  createDirectoryAndFile('lib/features/$featureName/presentation/screens');
  createDirectoryAndFile('lib/features/$featureName/presentation/widgets');

  print('Feature structure created successfully!');
}
