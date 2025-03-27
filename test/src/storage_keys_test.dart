// ignore_for_file: prefer_const_constructors
import 'package:ht_kv_storage_service/src/storage_keys.dart';
import 'package:test/test.dart';

void main() {
  group('StorageKeys', () {
    test('constants have correct values', () {
      expect(StorageKeys.pendingSignInEmail, equals('pending_signin_email'));
      expect(StorageKeys.hasSeenOnboarding, equals('has_seen_onboarding'));
    });

    // Since the constructor is private, we cannot test instantiation directly,
    // which is the intended behavior.
  });
}
