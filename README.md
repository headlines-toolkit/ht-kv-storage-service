# Key-Value Storage Service Interface

A Dart package defining an abstract interface (`HtKVStorageService`) for key-value storage. This promotes consistency and allows for interchangeable storage implementations (like SharedPreferences, Hive, secure storage, etc.).

## Features ✨

*   Defines a clear contract for basic key-value operations (read, write, delete) for common data types (`String`, `bool`, `int`, `double`).
*   Includes a `clearAll` method for removing all entries.
*   Provides a `StorageKeys` class example to avoid magic strings.

## Getting Started 🚀

### Prerequisites

*   Dart SDK installed.

### Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  ht_kv_storage_service:
    git:
      url: https://github.com/headlines-toolkit/ht-kv-storage-service.git
      ref: main
```

### Usage

1.  **Implement the Interface:** Create a concrete class that implements `HtKVStorageService` using your desired storage mechanism (e.g., `shared_preferences`).

    ```dart
    import 'package:ht_kv_storage_service/ht_kv_storage_service.dart';
    import 'package:shared_preferences/shared_preferences.dart';

    class HtKVStorageSharedPreferences implements HtKVStorageService {
      HtKVStorageSharedPreferences(this._prefs);

      final SharedPreferences _prefs;

      @override
      Future<void> writeString({required String key, required String value}) async {
        await _prefs.setString(key, value);
      }

      @override
      Future<String?> readString({required String key}) async {
        return _prefs.getString(key);
      }

      // ... implement other methods (writeBool, readBool, etc.) ...

      @override
      Future<void> delete({required String key}) async {
        await _prefs.remove(key);
      }

      @override
      Future<void> clearAll() async {
        await _prefs.clear();
      }
    }
    ```

2.  **Use the Service:** Inject or provide an instance of your concrete implementation and use the `HtKVStorageService` interface methods.

    ```dart
    import 'package:ht_kv_storage_service/ht_kv_storage_service.dart';
    // Import your concrete implementation

    Future<void> main() async {
      // Obtain an instance of your HtKVStorageService implementation
      // (e.g., using dependency injection or direct instantiation)
      // final prefs = await SharedPreferences.getInstance();
      // final storageService = HtKVStorageSharedPreferences(prefs);

      // Example usage:
      // await storageService.writeBool(key: StorageKeys.hasSeenOnboarding, value: true);
      // final hasSeenOnboarding = await storageService.readBool(key: StorageKeys.hasSeenOnboarding);
      // print('Has seen onboarding: $hasSeenOnboarding');
    }
    ```

## Running Tests 🧪

This package uses [Very Good Analysis](https://pub.dev/packages/very_good_analysis) for static analysis and aims for high test coverage.

To run tests and generate coverage:

```sh
dart pub global activate coverage 1.2.0 # Activate coverage tool if needed
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the HTML coverage report (requires `lcov` and `genhtml`):

```sh
genhtml coverage/lcov.info -o coverage/
open coverage/index.html # On macOS/Linux
# start coverage/index.html # On Windows
