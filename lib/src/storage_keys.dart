import 'package:ht_kv_storage_service/ht_kv_storage_service.dart';

/// {@template storage_keys}
/// Defines a collection of constant keys used for accessing values
/// stored within the [HtKVStorageService].
///
/// This class prevents the use of magic strings for keys, promoting
/// type safety and reducing potential runtime errors.
/// {@endtemplate}
class StorageKeys {
  /// Private constructor to prevent instantiation.
  const StorageKeys._();

  /// Key for storing the email address used during a passwordless sign-in
  /// process.
  static const String pendingSignInEmail = 'pending_signin_email';

  /// Key for storing a boolean flag indicating whether the user has completed
  /// the onboarding flow.
  static const String hasSeenOnboarding = 'has_seen_onboarding';
}
