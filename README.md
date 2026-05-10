# GetX Clean Architecture E-Commerce (Flutter)

This project is a lightweight eCommerce demo built with `GetX` and a clean architecture flow.

## Architecture Flow

`UI (Page/Widget) -> GetX Controller -> UseCase -> Repository (abstract) -> DataSource -> Model -> Entity`

## Folder Structure

```text
lib/
  app.dart
  main.dart
  core/
    bindings/
    routes/
    theme/
  data/
    models/
    repositories/
    sources/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    controllers/
    pages/
    widgets/
```

## Features

- Product listing with clean layered data flow
- Product detail page with hero animation
- Cart with quantity increment/decrement
- Reactive cart badge and total price (`Obx`)
- Centralized route + dependency bindings

## Run

```bash
flutter pub get
flutter run
```

## Verify

```bash
flutter analyze
flutter test
```
