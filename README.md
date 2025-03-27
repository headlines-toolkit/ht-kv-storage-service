# Key-Value Storage Service Interface

A Dart package defining an abstract interface (`HtKVStorageService`) for key-value storage. This promotes consistency and allows for interchangeable storage implementations (like SharedPreferences, Hive, secure storage, etc.).

## Features ✨

*   Defines a clear contract for basic key-value operations (read, write, delete) for common data types (`String`, `bool`, `int`, `double`).
*   Includes a `clearAll` method for removing all entries.
*   Provides a `StorageKey` enum to avoid magic strings, promoting type safety. Use the `stringValue` getter for the actual key string.
*   Defines a set of custom `StorageException` subclasses (`StorageWriteException`, `StorageReadException`, `StorageDeleteException`, `StorageClearException`, `StorageKeyNotFoundException`, `StorageTypeMismatchException`) to handle specific storage errors.

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
    // import 'package:your_package/your_storage_implementation.dart';

    Future<void> main() async {
      // Obtain an instance of your HtKVStorageService implementation
      // (e.g., using dependency injection or direct instantiation)
      // final prefs = await SharedPreferences.getInstance();
      // final storageService = HtKVStorageSharedPreferences(prefs);

      // Example usage:
      try {
        // Use the stringValue getter for the key
        await storageService.writeBool(
          key: StorageKey.hasSeenOnboarding.stringValue,
          value: true,
        );
        final hasSeenOnboarding = await storageService.readBool(
          key: StorageKey.hasSeenOnboarding.stringValue,
        );
        print('Has seen onboarding: $hasSeenOnboarding');
      } on StorageWriteException catch (e) {
        print('Failed to write: ${e.message}, Key: ${e.key}');
      } on StorageReadException catch (e) {
        print('Failed to read: ${e.message}, Key: ${e.key}');
      } on StorageTypeMismatchException catch (e) {
        print('Type mismatch: ${e.message}, Key: ${e.key}, Expected: ${e.expectedType}, Found: ${e.actualType}');
      } catch (e) {
        // Handle other potential exceptions
        print('An unexpected error occurred: $e');
      }
    }
    ```

## Error Handling

The `HtKVStorageService` methods may throw specific exceptions derived from `StorageException` upon failure:

*   `StorageWriteException`: Thrown by `write*` methods on failure.
*   `StorageReadException`: Thrown by `read*` methods on general read failure.
*   `StorageDeleteException`: Thrown by `delete` on failure.
*   `StorageClearException`: Thrown by `clearAll` on failure.
*   `StorageKeyNotFoundException`: May be thrown by `delete` if the key doesn't exist (implementation-dependent). `read*` methods typically return `null` or a default value instead.
*   `StorageTypeMismatchException`: Thrown by `read*` methods if the stored data type doesn't match the expected type.

Implementations should handle these exceptions appropriately (e.g., using `try-catch` blocks).
