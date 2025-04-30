# Clean Architecture Project Template

This document defines the structure and rules for generating a clean architecture Flutter project.

## Project Structure

```
lib/
  ├── core/
  │   ├── constants/      # Global constants and configurations
  │   ├── errors/         # Custom exceptions and failures
  │   ├── network/        # Network-related utilities
  │   ├── usecases/       # Base usecase implementations
  │   └── utils/          # Common utilities and helpers
  ├── features/
  │   └── [feature_name]/
  │       ├── data/
  │       │   ├── datasources/
  │       │   │   ├── local_datasource/    # Local data source implementations
  │       │   │   └── remote_datasource/   # Remote data source implementations
  │       │   ├── models/                  # Data models
  │       │   └── repositories/            # Repository implementations
  │       ├── domain/
  │       │   ├── entities/                # Business entities
  │       │   ├── repositories/            # Repository interfaces
  │       │   └── usecases/                # Business logic usecases
  │       └── presentation/
  │           ├── bloc/                    # State management
  │           ├── pages/                   # Screen implementations
  │           └── widgets/                 # Reusable widgets
  └── injection_container.dart             # Dependency injection setup
```

## Naming Conventions

### Files
- Use snake_case for file names
- Suffix files with their type:
  - `_bloc.dart` for BLoC files
  - `_event.dart` for event files
  - `_state.dart` for state files
  - `_repository.dart` for repository interfaces
  - `_repository_impl.dart` for repository implementations
  - `_datasource.dart` for data source interfaces
  - `_datasource_impl.dart` for data source implementations
  - `_usecase.dart` for use case files

### Classes
- Use PascalCase for class names
- Prefix classes with their feature name:
  - `FeatureNameBloc`
  - `FeatureNameEvent`
  - `FeatureNameState`
  - `FeatureNameRepository`
  - `FeatureNameRepositoryImpl`
  - `FeatureNameDataSource`
  - `FeatureNameDataSourceImpl`
  - `FeatureNameUseCase`

## Code Organization Rules

### Data Layer
- Models should be simple data classes
- Data sources should handle data operations
- Repository implementations should coordinate between data sources

### Domain Layer
- Entities should be pure business objects
- Repository interfaces should define contracts
- Use cases should contain business logic

### Presentation Layer
- BLoC should handle state management
- Pages should be stateless widgets
- Widgets should be reusable components

## File Templates

### BLoC Template
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '${feature_name}_event.dart';
import '${feature_name}_state.dart';

class ${FeatureName}Bloc extends Bloc<${FeatureName}Event, ${FeatureName}State> {
  ${FeatureName}Bloc() : super(${FeatureName}Initial()) {
    // Add event handlers here
  }
}
```

### Repository Template
```dart
import 'package:clean_structure/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ${FeatureName}Repository {
  // Define repository methods here
}
```

### Use Case Template
```dart
import 'package:clean_structure/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class ${FeatureName}UseCase implements UseCase<Type, Params> {
  @override
  Future<Either<Failure, Type>> call(Params params) async {
    // Implement use case logic here
  }
}
```

## Dependency Rules

- Presentation layer depends on Domain layer
- Domain layer depends on nothing
- Data layer depends on Domain layer
- Core layer can be used by all layers

## Error Handling

- Use Either type for error handling
- Define custom exceptions in core/errors
- Handle network errors appropriately
- Provide meaningful error messages

## Testing Rules

- Write unit tests for use cases
- Write integration tests for repositories
- Write widget tests for UI components
- Mock external dependencies

## Code Style

- Follow Dart style guide
- Use proper documentation
- Keep files focused and small
- Use meaningful names
- Avoid magic numbers and strings 