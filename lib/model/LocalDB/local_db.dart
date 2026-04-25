import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static const String _tokenKey = 'auth_token';

  static Future<bool> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<bool> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final String? token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
