# Clean Structure Generator

A CLI tool for generating clean architecture Flutter project structures.

## Features

- Generates a clean architecture project structure
- Creates feature/layer modules with proper separation of concerns
- Follows clean architecture principles
- Easy to use command-line interface

## Installation

```bash
# Activate
dart pub global activate clean_structure

# Deactivate
dart pub global deactivate clean_structure
```

## Usage

### Create a new project structure

```bash
clean_structure create
```

This will generate a clean architecture project structure in your current Flutter project.

### Generate a new feature

```bash
clean_structure feature --name user_auth
# or
clean_structure feature -n user_auth
```

### Generate a new layer

```bash
clean_structure layer --name user_auth
# or
clean_structure layer -n user_auth
```

This will generate a new feature module with proper clean architecture structure.

### Create a template with specific architecture

```bash
# For feature-driven architecture
clean_structure template --type feature
# or
clean_structure template -t feature

# For layer-driven architecture
clean_structure template --type layer
# or
clean_structure template -t layer
```

This will create a template with the specified architecture type in your project root.

### Show help

```bash
clean_structure help
# or
clean_structure --help
# or
clean_structure -h
```

## Project Structure

The generated project follows clean architecture principles with the following structure:

Feature First :

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── network/
  │   └── usecases/
  │    
  ├── features/
  │   └── [feature_name]/
  │       ├── data/
  │       │   ├── datasources/
  │       │   ├── models/
  │       │   └── repositories/
  │       ├── domain/
  │       │   ├── entities/
  │       │   ├── repositories/
  │       │   └── usecases/
  │       └── presentation/
  │           ├── bloc/
  │           ├── pages/
  │           └── widgets/
  └── injection_container.dart
```

Layer First: 

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── network/
  │   └── usecases/
  │   
  ├── data/
  │   ├── datasources/
  │   ├── models/
  │   └── repositories/
  │
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  │
  ├── presentation/
  │   ├── bloc/
  │   ├── pages/
  │   └── widgets/

  └── injection_container.dart
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
