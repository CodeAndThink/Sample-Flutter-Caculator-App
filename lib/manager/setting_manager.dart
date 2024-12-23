import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingManager {
  final _storage = const FlutterSecureStorage();
  static final shared = SettingManager();

  Future<void> saveUserThemeMode(bool isDarkMode) async {
    final themeMode = isDarkMode ? "dark" : "light";
    await _storage.write(key: "thememode", value: themeMode);
  }

  Future<bool> getUserThemeMode() async {
    final themeMode = await _storage.read(key: "thememode");
    if (themeMode != null) {
      return themeMode == "dark";
    }
    return false;
  }
}
