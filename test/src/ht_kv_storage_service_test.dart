import 'package:ht_kv_storage_service/ht_kv_storage_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

// Create a mock implementation of the abstract class
class MockHtKVStorageService extends Mock implements HtKVStorageService {}

void main() {
  group('HtKVStorageService Abstract Class', () {
    late MockHtKVStorageService mockStorageService;

    setUp(() {
      mockStorageService = MockHtKVStorageService();

      // Register fallback values for methods returning non-nullable types
      // or futures of non-nullable types, if needed by specific tests.
      // For basic coverage, stubbing might be sufficient.
      registerFallbackValue(''); // For String key
      registerFallbackValue(false); // For bool value/defaultValue
      registerFallbackValue(0); // For int value
      registerFallbackValue(0.0); // For double value

      // Stubbing the methods to return default futures/values
      // This ensures the methods can be called without null errors
      // and contributes to coverage.
      when(
        () => mockStorageService.writeString(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockStorageService.readString(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(
        () => mockStorageService.writeBool(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => mockStorageService.readBool(
          key: any(named: 'key'),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenAnswer((_) async => false); // Return default
      when(
        () => mockStorageService.readBool(
          key: any(named: 'key'),
        ),
      ) // Handle call without defaultValue
          .thenAnswer((_) async => false);
      when(
        () => mockStorageService.writeInt(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockStorageService.readInt(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(
        () => mockStorageService.writeDouble(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async {});
      when(() => mockStorageService.readDouble(key: any(named: 'key')))
          .thenAnswer((_) async => null);
      when(() => mockStorageService.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});
      when(() => mockStorageService.clearAll()).thenAnswer((_) async {});
    });

    // Test calling each method to ensure coverage of the abstract definition
    test('writeString can be called', () async {
      await mockStorageService.writeString(key: 'testKey', value: 'testValue');
      verify(
        () => mockStorageService.writeString(
          key: 'testKey',
          value: 'testValue',
        ),
      ).called(1);
    });

    test('readString can be called', () async {
      await mockStorageService.readString(key: 'testKey');
      verify(() => mockStorageService.readString(key: 'testKey')).called(1);
    });

    test('writeBool can be called', () async {
      await mockStorageService.writeBool(key: 'testKey', value: true);
      verify(() => mockStorageService.writeBool(key: 'testKey', value: true))
          .called(1);
    });

    test('readBool can be called with default', () async {
      await mockStorageService.readBool(key: 'testKey', defaultValue: true);
      verify(
        () => mockStorageService.readBool(key: 'testKey', defaultValue: true),
      ).called(1);
    });

    test('readBool can be called without default', () async {
      await mockStorageService.readBool(key: 'testKey');
      verify(() => mockStorageService.readBool(key: 'testKey')).called(1);
    });

    test('writeInt can be called', () async {
      await mockStorageService.writeInt(key: 'testKey', value: 123);
      verify(() => mockStorageService.writeInt(key: 'testKey', value: 123))
          .called(1);
    });

    test('readInt can be called', () async {
      await mockStorageService.readInt(key: 'testKey');
      verify(() => mockStorageService.readInt(key: 'testKey')).called(1);
    });

    test('writeDouble can be called', () async {
      await mockStorageService.writeDouble(key: 'testKey', value: 1.23);
      verify(() => mockStorageService.writeDouble(key: 'testKey', value: 1.23))
          .called(1);
    });

    test('readDouble can be called', () async {
      await mockStorageService.readDouble(key: 'testKey');
      verify(() => mockStorageService.readDouble(key: 'testKey')).called(1);
    });

    test('delete can be called', () async {
      await mockStorageService.delete(key: 'testKey');
      verify(() => mockStorageService.delete(key: 'testKey')).called(1);
    });

    test('clearAll can be called', () async {
      await mockStorageService.clearAll();
      verify(() => mockStorageService.clearAll()).called(1);
    });
  });
}
