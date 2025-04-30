# Clean Structure Generator

A CLI tool for generating clean architecture Flutter project structures.

## Features

- Generates a clean architecture project structure
- Creates feature modules with proper separation of concerns
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

This will generate a new feature module with proper clean architecture structure.

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

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── network/
  │   ├── usecases/
  │   └── utils/
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

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

# Генератор Чистой Архитектуры

Командный инструмент для генерации структур проектов с чистой архитектурой в приложениях Flutter.

## Возможности

- Генерация структуры проекта с чистой архитектурой
- Создание модулей функций с правильным разделением ответственности
- Следование принципам чистой архитектуры
- Простой в использовании интерфейс командной строки

## Установка

```bash
# Активация
dart pub global activate clean_structure

# Деактивация
dart pub global deactivate clean_structure
```

## Использование

### Создание структуры проекта

```bash
clean_structure create
```

Это создаст структуру проекта с чистой архитектурой в вашем текущем проекте Flutter.

### Создание новой функции

```bash
clean_structure feature --name user_auth
# или
clean_structure feature -n user_auth
```

Это создаст новый модуль функции с правильной структурой чистой архитектуры.

### Показать справку

```bash
clean_structure help
# или
clean_structure --help
# или
clean_structure -h
```

## Структура проекта

Сгенерированный проект следует принципам чистой архитектуры со следующей структурой:

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── network/
  │   ├── usecases/
  │   └── utils/
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

---

# Toza Arxitektura Generatori

Flutter ilovalari uchun toza arxitekturaga asoslangan loyiha strukturalarini yaratish uchun komanda satri vositasi.

## Imkoniyatlar

- Toza arxitekturaga asoslangan loyiha strukturasini yaratish
- Funksiyalar modullarini to'g'ri bo'linish bilan yaratish
- Toza arxitektura tamoyillariga amal qilish
- Oson ishlatiladigan komanda satri interfeysi

## O'rnatish

```bash
# Faollashtirish
dart pub global activate clean_structure

# O'chirish
dart pub global deactivate clean_structure
```

## Foydalanish

### Loyiha strukturasini yaratish

```bash
clean_structure create
```

Bu sizning joriy Flutter loyihangizda toza arxitekturaga asoslangan struktura yaratadi.

### Yangi funksiya yaratish

```bash
clean_structure feature --name user_auth
# yoki
clean_structure feature -n user_auth
```

Bu toza arxitekturaga mos yangi funksiya modulini yaratadi.

### Yordam ko'rsatish

```bash
clean_structure help
# yoki
clean_structure --help
# yoki
clean_structure -h
```

## Loyiha Strukturasi

Yaratilgan loyiha toza arxitektura tamoyillariga asoslangan quyidagi strukturaga ega:

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── errors/
  │   ├── network/
  │   ├── usecases/
  │   └── utils/
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
