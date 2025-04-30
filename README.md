# TDD Structure Generator

A command-line tool for generating TDD (Test-Driven Development) project structures in Flutter applications.

## Features

- Generate core project structure
- Generate feature-specific structure following clean architecture
- Support for data, domain, and presentation layers
- Automatic creation of necessary files and directories
- Proper naming conventions and file organization

## Installation

```bash
dart pub global activate --source git https://github.com/otabekmuradov/tdd_architecture_gen
```

## Usage

### Generate Core Structure

```bash
tdd_structure --name your_project_name
```

This will create the following core structure:
- core/
  - services/
  - widgets/
  - enums/
  - constants/
  - bloc/
  - config/
  - di/
  - errors/
  - extensions/
  - observers/
  - routes/
  - themes/
  - usecases/
  - utils/

### Generate Feature Structure

```bash
tdd_structure --feature feature_name
```

This will create a feature structure with:
- data/
  - data_sources/
    - local_datasource/
    - remote_datasource/
  - models/
  - repositories/
- domain/
  - entities/
  - repositories/
  - usecases/
- presentation/
  - bloc/
  - screens/
  - widgets/

## Available Commands

- `--name` or `-n`: Specify project name for core structure
- `--feature` or `-f`: Specify feature name for feature structure
- `--help` or `-h`: Show usage information

---

# Генератор TDD Структуры

Командный инструмент для генерации структур проектов TDD (Test-Driven Development) в приложениях Flutter.

## Возможности

- Генерация основной структуры проекта
- Генерация структуры для конкретных функций в соответствии с чистой архитектурой
- Поддержка слоев данных, домена и представления
- Автоматическое создание необходимых файлов и директорий
- Правильные соглашения об именовании и организация файлов

## Установка

```bash
dart pub global activate --source git https://github.com/otabekmuradov/tdd_architecture_gen
```

## Использование

### Генерация Основной Структуры

```bash
tdd_structure --name имя_вашего_проекта
```

Создает следующую основную структуру:
- core/
  - services/
  - widgets/
  - enums/
  - constants/
  - bloc/
  - config/
  - di/
  - errors/
  - extensions/
  - observers/
  - routes/
  - themes/
  - usecases/
  - utils/

### Генерация Структуры Функции

```bash
tdd_structure --feature имя_функции
```

Создает структуру функции со следующими компонентами:
- data/
  - data_sources/
    - local_datasource/
    - remote_datasource/
  - models/
  - repositories/
- domain/
  - entities/
  - repositories/
  - usecases/
- presentation/
  - bloc/
  - screens/
  - widgets/

## Доступные Команды

- `--name` или `-n`: Указать имя проекта для основной структуры
- `--feature` или `-f`: Указать имя функции для структуры функции
- `--help` или `-h`: Показать информацию об использовании

---

# TDD Struktura Generatori

Flutter ilovalarida TDD (Test-Driven Development) loyiha strukturalarini yaratish uchun komanda satri vositasi.

## Imkoniyatlar

- Asosiy loyiha strukturasini yaratish
- Toza arxitekturaga mos ravishda funksiyalar uchun struktura yaratish
- Ma'lumotlar, domen va taqdimot qatlamlarini qo'llab-quvvatlash
- Kerakli fayllar va kataloglarni avtomatik yaratish
- To'g'ri nomlash qoidalari va fayl tashkili

## O'rnatish

```bash
dart pub global activate --source git https://github.com/otabekmuradov/tdd_architecture_gen
```

## Foydalanish

### Asosiy Struktura Yaratish

```bash
tdd_structure --name loyiha_nomi
```

Quyidagi asosiy struktura yaratiladi:
- core/
  - services/
  - widgets/
  - enums/
  - constants/
  - bloc/
  - config/
  - di/
  - errors/
  - extensions/
  - observers/
  - routes/
  - themes/
  - usecases/
  - utils/

### Funksiya Strukturasi Yaratish

```bash
tdd_structure --feature funksiya_nomi
```

Funksiya strukturasini quyidagi komponentlar bilan yaratadi:
- data/
  - data_sources/
    - local_datasource/
    - remote_datasource/
  - models/
  - repositories/
- domain/
  - entities/
  - repositories/
  - usecases/
- presentation/
  - bloc/
  - screens/
  - widgets/

## Mavjud Buyruqlar

- `--name` yoki `-n`: Asosiy struktura uchun loyiha nomini belgilash
- `--feature` yoki `-f`: Funksiya strukturasini uchun funksiya nomini belgilash
- `--help` yoki `-h`: Foydalanish haqida ma'lumot ko'rsatish
