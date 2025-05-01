# Layer-Driven Architecture Template

This template describes the structure and organization of a layer-driven architecture in Flutter.

## Project Structure

```
lib/
  ├── data/
  │   ├── datasources/
  │   │   ├── local_datasources/
  │   │   └── remote_datasources/
  │   ├── models/
  │   └── repositories/
  ├── domain/
  │   ├── entities/
  │   ├── repositories/
  │   └── usecases/
  └── presentation/
      ├── blocs/
      ├── pages/
      └── widgets/
```

## Data Layer
The data layer is responsible for data operations:
- Datasources: Local and remote data sources
  - Local: SQLite, SharedPreferences, etc.
  - Remote: API calls, network requests
- Models: Data models and DTOs
- Repositories: Implementation of repository interfaces

## Domain Layer
The domain layer contains business logic:
- Entities: Business objects and domain models
- Repositories: Repository interfaces
- Usecases: Business logic and use cases

## Presentation Layer
The presentation layer handles UI and user interaction:
- Blocs: State management using BLoC pattern
- Pages: Screen implementations
- Widgets: Reusable UI components

## Usage
To create a new layer:
```bash
clean_structure layer --name your_layer_name
```

This will generate the complete layer structure with all necessary files and folders. 