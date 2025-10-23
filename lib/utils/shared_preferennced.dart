import 'package:shared_preferences/shared_preferences.dart';

/// Helper class untuk manage user session & data lokal
/// Menyimpan: onboarding status, user login, role, dll
class SharedPreferencesHelper {
  // Keys untuk SharedPreferences
  static const String _keyHasSeenOnboarding = 'hasSeenOnboarding';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserRole = 'userRole';
  static const String _keyUsername = 'username';
  static const String _keyLoginTime = 'loginTime';

  // ==================== ONBOARDING ====================

  /// Cek apakah user sudah pernah lihat onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasSeenOnboarding) ?? false;
  }

  /// Set status onboarding sudah dilihat
  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasSeenOnboarding, true);
  }

  // ==================== USER LOGIN ====================

  /// Cek apakah user sudah login
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Simpan data login user
  static Future<void> saveUserLogin({
    required String username,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUsername, username);
    await prefs.setString(_keyUserRole, role);
    await prefs.setString(_keyLoginTime, DateTime.now().toIso8601String());
  }

  /// Get username yang login
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  /// Get role user yang login
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserRole);
  }

  /// Get waktu login terakhir
  static Future<DateTime?> getLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timeString = prefs.getString(_keyLoginTime);
    if (timeString != null) {
      return DateTime.parse(timeString);
    }
    return null;
  }

  /// Get semua data user yang login
  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'isLoggedIn': prefs.getBool(_keyIsLoggedIn) ?? false,
      'username': prefs.getString(_keyUsername),
      'role': prefs.getString(_keyUserRole),
      'loginTime': prefs.getString(_keyLoginTime),
      'hasSeenOnboarding': prefs.getBool(_keyHasSeenOnboarding) ?? false,
    };
  }

  // ==================== LOGOUT ====================

  /// Logout user (hapus data login tapi tetap simpan onboarding status)
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsLoggedIn);
    await prefs.remove(_keyUsername);
    await prefs.remove(_keyUserRole);
    await prefs.remove(_keyLoginTime);
    // TIDAK hapus _keyHasSeenOnboarding agar tidak muncul lagi
  }

  // ==================== CLEAR ALL ====================

  /// Hapus semua data (untuk testing/reset app)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  /// Reset hanya data login (tetap simpan onboarding)
  static Future<void> resetLoginOnly() async {
    await logout();
  }

  /// Reset hanya onboarding (untuk testing)
  static Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHasSeenOnboarding);
  }

  // ==================== HELPER METHODS ====================

  /// Print semua data yang tersimpan (untuk debugging)
  static Future<void> printAllData() async {
    final prefs = await SharedPreferences.getInstance();
    print('=== SharedPreferences Data ===');
    print('Has Seen Onboarding: ${prefs.getBool(_keyHasSeenOnboarding)}');
    print('Is Logged In: ${prefs.getBool(_keyIsLoggedIn)}');
    print('Username: ${prefs.getString(_keyUsername)}');
    print('User Role: ${prefs.getString(_keyUserRole)}');
    print('Login Time: ${prefs.getString(_keyLoginTime)}');
    print('==============================');
  }

  /// Cek apakah ini first time user buka app
  static Future<bool> isFirstTimeUser() async {
    final hasSeenOnboarding = await SharedPreferencesHelper.hasSeenOnboarding();
    final isLoggedIn = await SharedPreferencesHelper.isLoggedIn();
    return !hasSeenOnboarding && !isLoggedIn;
  }

  /// Cek apakah session masih valid (contoh: 30 hari)
  static Future<bool> isSessionValid({int daysValid = 30}) async {
    final loginTime = await getLoginTime();
    if (loginTime == null) return false;

    final difference = DateTime.now().difference(loginTime);
    return difference.inDays < daysValid;
  }

  /// Get durasi user sudah login (dalam hari)
  static Future<int?> getLoginDuration() async {
    final loginTime = await getLoginTime();
    if (loginTime == null) return null;

    final difference = DateTime.now().difference(loginTime);
    return difference.inDays;
  }
}
