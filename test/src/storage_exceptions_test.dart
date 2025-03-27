// ignore_for_file: lines_longer_than_80_chars

import 'package:ht_kv_storage_service/ht_kv_storage_service.dart';
import 'package:test/test.dart';

void main() {
  group('Storage Exceptions', () {
    final testCause = Exception('Underlying cause');
    const testKey = 'myTestKey';
    const testValue = 'myTestValue';
    const testMessage = 'Custom error message';

    group('StorageInitializationException', () {
      test('can be instantiated without parameters', () {
        const exception = StorageInitializationException();
        expect(exception.message, isNull);
        expect(exception.cause, isNull);
        expect(exception.toString(), 'StorageInitializationException');
      });

      test('can be instantiated with message and cause', () {
        final exception = StorageInitializationException(
          message: testMessage,
          cause: testCause,
        );
        expect(exception.message, testMessage);
        expect(exception.cause, testCause);
        expect(
          exception.toString(),
          'StorageInitializationException: $testMessage\nCaused by: $testCause',
        );
      });
    });

    group('StorageWriteException', () {
      test('can be instantiated with key and value', () {
        const exception = StorageWriteException(testKey, testValue);
        expect(exception.key, testKey);
        expect(exception.value, testValue);
        expect(exception.message, 'Failed to write value for key.');
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageWriteException: Failed to write value for key. Key: "$testKey"',
        );
      });

      test('can be instantiated with message and cause', () {
        final exception = StorageWriteException(
          testKey,
          testValue,
          message: testMessage,
          cause: testCause,
        );
        expect(exception.key, testKey);
        expect(exception.value, testValue);
        expect(exception.message, testMessage);
        expect(exception.cause, testCause);
        expect(
          exception.toString(),
          'StorageWriteException: $testMessage Key: "$testKey"\nCaused by: $testCause',
        );
      });
    });

    group('StorageReadException', () {
      test('can be instantiated with key', () {
        const exception = StorageReadException(testKey);
        expect(exception.key, testKey);
        expect(exception.message, 'Failed to read value for key.');
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageReadException: Failed to read value for key. Key: "$testKey"',
        );
      });

      test('can be instantiated with message and cause', () {
        final exception = StorageReadException(
          testKey,
          message: testMessage,
          cause: testCause,
        );
        expect(exception.key, testKey);
        expect(exception.message, testMessage);
        expect(exception.cause, testCause);
        expect(
          exception.toString(),
          'StorageReadException: $testMessage Key: "$testKey"\nCaused by: $testCause',
        );
      });
    });

    group('StorageDeleteException', () {
      test('can be instantiated with key', () {
        const exception = StorageDeleteException(testKey);
        expect(exception.key, testKey);
        expect(exception.message, 'Failed to delete value for key.');
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageDeleteException: Failed to delete value for key. Key: "$testKey"',
        );
      });

      test('can be instantiated with message and cause', () {
        final exception = StorageDeleteException(
          testKey,
          message: testMessage,
          cause: testCause,
        );
        expect(exception.key, testKey);
        expect(exception.message, testMessage);
        expect(exception.cause, testCause);
        expect(
          exception.toString(),
          'StorageDeleteException: $testMessage Key: "$testKey"\nCaused by: $testCause',
        );
      });
    });

    group('StorageClearException', () {
      test('can be instantiated without parameters', () {
        const exception = StorageClearException();
        expect(exception.message, 'Failed to clear storage.');
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageClearException: Failed to clear storage.',
        );
      });

      test('can be instantiated with message and cause', () {
        final exception = StorageClearException(
          message: testMessage,
          cause: testCause,
        );
        expect(exception.message, testMessage);
        expect(exception.cause, testCause);
        expect(
          exception.toString(),
          'StorageClearException: $testMessage\nCaused by: $testCause',
        );
      });
    });

    group('StorageKeyNotFoundException', () {
      test('can be instantiated with key', () {
        const exception = StorageKeyNotFoundException(testKey);
        expect(exception.key, testKey);
        expect(exception.message, 'Key not found in storage.');
        expect(exception.cause, isNull); // Cause is always null
        expect(
          exception.toString(),
          'StorageKeyNotFoundException: Key not found in storage. Key: "$testKey"',
        );
      });

      test('can be instantiated with custom message', () {
        const exception = StorageKeyNotFoundException(
          testKey,
          message: testMessage,
        );
        expect(exception.key, testKey);
        expect(exception.message, testMessage);
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageKeyNotFoundException: $testMessage Key: "$testKey"',
        );
      });
    });

    group('StorageTypeMismatchException', () {
      const expectedType = String;
      const actualType = int;

      test('can be instantiated with key, expectedType, actualType', () {
        const exception = StorageTypeMismatchException(
          testKey,
          expectedType,
          actualType,
        );
        expect(exception.key, testKey);
        expect(exception.expectedType, expectedType);
        expect(exception.actualType, actualType);
        expect(exception.message, 'Type mismatch for key.');
        expect(exception.cause, isNull); // Cause is always null
        expect(
          exception.toString(),
          'StorageTypeMismatchException: Type mismatch for key. Key: "$testKey", Expected: $expectedType, Found: $actualType',
        );
      });

      test('can be instantiated with custom message', () {
        const exception = StorageTypeMismatchException(
          testKey,
          expectedType,
          actualType,
          message: testMessage,
        );
        expect(exception.key, testKey);
        expect(exception.expectedType, expectedType);
        expect(exception.actualType, actualType);
        expect(exception.message, testMessage);
        expect(exception.cause, isNull);
        expect(
          exception.toString(),
          'StorageTypeMismatchException: $testMessage Key: "$testKey", Expected: $expectedType, Found: $actualType',
        );
      });
    });
  });
}
