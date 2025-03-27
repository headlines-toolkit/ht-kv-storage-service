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
  /// Throws an exception if the write operation fails.
  Future<void> writeString({required String key, required String value});

  /// Reads the string value associated with the given [key].
  ///
  /// Returns `null` if the key is not found or if the stored value
  /// is not a string.
  /// Throws an exception if the read operation fails.
  Future<String?> readString({required String key});

  /// Writes a boolean value associated with the given [key].
  ///
  /// Throws an exception if the write operation fails.
  Future<void> writeBool({required String key, required bool value});

  /// Reads the boolean value associated with the given [key].
  ///
  /// Returns [defaultValue] (defaulting to `false`) if the key is not found
  /// or if the stored value is not a boolean.
  /// Throws an exception if the read operation fails.
  Future<bool> readBool({required String key, bool defaultValue = false});

  /// Writes an integer value associated with the given [key].
  ///
  /// Throws an exception if the write operation fails.
  Future<void> writeInt({required String key, required int value});

  /// Reads the integer value associated with the given [key].
  ///
  /// Returns `null` if the key is not found or if the stored value
  /// is not an integer.
  /// Throws an exception if the read operation fails.
  Future<int?> readInt({required String key});

  /// Writes a double value associated with the given [key].
  ///
  /// Throws an exception if the write operation fails.
  Future<void> writeDouble({required String key, required double value});

  /// Reads the double value associated with the given [key].
  ///
  /// Returns `null` if the key is not found or if the stored value
  /// is not a double.
  /// Throws an exception if the read operation fails.
  Future<double?> readDouble({required String key});

  /// Deletes the value associated with the given [key].
  ///
  /// If the key does not exist, this operation does nothing.
  /// Throws an exception if the delete operation fails.
  Future<void> delete({required String key});

  /// Deletes all key-value pairs from the storage.
  ///
  /// Use with caution, as this operation is irreversible.
  /// Throws an exception if the clear operation fails.
  Future<void> clearAll();
}
