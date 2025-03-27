// ignore_for_file: lines_longer_than_80_chars

/// {@template storage_exception}
/// Base class for all key-value storage related exceptions.
/// {@endtemplate}
abstract class StorageException implements Exception {
  /// {@macro storage_exception}
  const StorageException({this.message, this.cause});

  /// Optional original exception that caused this storage exception.
  final Object? cause;

  /// Optional message describing the error.
  final String? message;

  @override
  String toString() {
    var result = runtimeType.toString();
    if (message != null) {
      result += ': $message';
    }
    if (cause != null) {
      result += '\nCaused by: $cause';
    }
    return result;
  }
}

/// {@template storage_initialization_exception}
/// Exception thrown when a storage operation fails during initialization.
/// {@endtemplate}
class StorageInitializationException extends StorageException {
  /// {@macro storage_initialization_exception}
  const StorageInitializationException({super.message, super.cause});
}

/// {@template storage_write_exception}
/// Exception thrown when a write operation fails.
/// {@endtemplate}
class StorageWriteException extends StorageException {
  /// {@macro storage_write_exception}
  const StorageWriteException(
    this.key,
    this.value, {
    super.message = 'Failed to write value for key.',
    super.cause,
  });

  /// The key associated with the failed write operation.
  final String key;

  /// The value that failed to be written.
  final dynamic value;

  @override
  String toString() {
    var result = 'StorageWriteException: $message Key: "$key"';
    if (cause != null) {
      result += '\nCaused by: $cause';
    }
    return result;
  }
}

/// {@template storage_read_exception}
/// Exception thrown when a read operation fails for reasons other than
/// key not found or type mismatch.
/// {@endtemplate}
class StorageReadException extends StorageException {
  /// {@macro storage_read_exception}
  const StorageReadException(
    this.key, {
    super.message = 'Failed to read value for key.',
    super.cause,
  });

  /// The key associated with the failed read operation.
  final String key;

  @override
  String toString() {
    var result = 'StorageReadException: $message Key: "$key"';
    if (cause != null) {
      result += '\nCaused by: $cause';
    }
    return result;
  }
}

/// {@template storage_delete_exception}
/// Exception thrown when a delete operation fails.
/// {@endtemplate}
class StorageDeleteException extends StorageException {
  /// {@macro storage_delete_exception}
  const StorageDeleteException(
    this.key, {
    super.message = 'Failed to delete value for key.',
    super.cause,
  });

  /// The key associated with the failed delete operation.
  final String key;

  @override
  String toString() {
    var result = 'StorageDeleteException: $message Key: "$key"';
    if (cause != null) {
      result += '\nCaused by: $cause';
    }
    return result;
  }
}

/// {@template storage_clear_exception}
/// Exception thrown when the clear operation fails.
/// {@endtemplate}
class StorageClearException extends StorageException {
  /// {@macro storage_clear_exception}
  const StorageClearException({
    super.message = 'Failed to clear storage.',
    super.cause,
  });
}

/// {@template storage_key_not_found_exception}
/// Exception thrown when attempting to read or delete a key that does not exist.
///
/// Note: `read*` methods might return null instead of throwing this,
/// depending on the implementation contract.
/// {@endtemplate}
class StorageKeyNotFoundException extends StorageException {
  /// {@macro storage_key_not_found_exception}
  const StorageKeyNotFoundException(
    this.key, {
    super.message = 'Key not found in storage.',
  }) : super(cause: null);

  /// The key that was not found.
  final String key; // Typically not caused by another exception

  @override
  String toString() {
    return 'StorageKeyNotFoundException: $message Key: "$key"';
  }
}

/// {@template storage_type_mismatch_exception}
/// Exception thrown when the data retrieved from storage does not match
/// the expected type.
/// {@endtemplate}
class StorageTypeMismatchException extends StorageException {
  /// {@macro storage_type_mismatch_exception}
  const StorageTypeMismatchException(
    this.key,
    this.expectedType,
    this.actualType, {
    super.message = 'Type mismatch for key.',
  }) : super(cause: null);

  /// The key associated with the type mismatch.
  final String key;

  /// The type that was expected.
  final Type expectedType;

  /// The actual type found in storage.
  final Type actualType; // Typically not caused by another exception

  @override
  String toString() {
    return 'StorageTypeMismatchException: $message Key: "$key", Expected: $expectedType, Found: $actualType';
  }
}

// endregion

/// {@template key_value_storage_service}
/// Defines the contract for a generic key-value storage service.
///
/// This abstract class provides a common interface for various
/// key-value storage implementations (e.g., SharedPreferences, Hive,
/// secure storage). It allows for storing and retrieving basic data types
/// associated with string keys.
/// {@endtemplate}
abstract class HtKVStorageService {
  /// Writes a string value associated with the given [key].
  ///
  /// Throws a [StorageWriteException] if the write operation fails.
  Future<void> writeString({required String key, required String value});

  /// Reads the string value associated with the given [key].
  ///
  /// Returns `null` if the key is not found.
  /// Throws a [StorageReadException] if the read operation fails for other reasons.
  /// Throws a [StorageTypeMismatchException] if the stored value is not a string.
  Future<String?> readString({required String key});

  /// Writes a boolean value associated with the given [key].
  ///
  /// Throws a [StorageWriteException] if the write operation fails.
  Future<void> writeBool({required String key, required bool value});

  /// Reads the boolean value associated with the given [key].
  ///
  /// Returns [defaultValue] (defaulting to `false`) if the key is not found.
  /// Throws a [StorageReadException] if the read operation fails for other reasons.
  /// Throws a [StorageTypeMismatchException] if the stored value is not a boolean.
  Future<bool> readBool({required String key, bool defaultValue = false});

  /// Writes an integer value associated with the given [key].
  ///
  /// Throws a [StorageWriteException] if the write operation fails.
  Future<void> writeInt({required String key, required int value});

  /// Reads the integer value associated with the given [key].
  ///
  /// Returns `null` if the key is not found.
  /// Throws a [StorageReadException] if the read operation fails for other reasons.
  /// Throws a [StorageTypeMismatchException] if the stored value is not an integer.
  Future<int?> readInt({required String key});

  /// Writes a double value associated with the given [key].
  ///
  /// Throws a [StorageWriteException] if the write operation fails.
  Future<void> writeDouble({required String key, required double value});

  /// Reads the double value associated with the given [key].
  ///
  /// Returns `null` if the key is not found.
  /// Throws a [StorageReadException] if the read operation fails for other reasons.
  /// Throws a [StorageTypeMismatchException] if the stored value is not a double.
  Future<double?> readDouble({required String key});

  /// Deletes the value associated with the given [key].
  ///
  /// If the key does not exist, this operation should ideally complete without
  /// throwing an error, but implementations might throw [StorageKeyNotFoundException].
  /// Throws a [StorageDeleteException] if the delete operation fails for other reasons.
  Future<void> delete({required String key});

  /// Deletes all key-value pairs from the storage.
  ///
  /// Use with caution, as this operation is irreversible.
  /// Throws a [StorageClearException] if the clear operation fails.
  Future<void> clearAll();
}
