import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerUtil {
  static late SessionManagerUtil _sessionManager;
  static late SharedPreferences _preferences;

  static Future<SessionManagerUtil> getInstance() async {
    if (_sessionManager == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = SessionManagerUtil._();
      await secureStorage._init();
      _sessionManager = secureStorage;
    }
    return _sessionManager;
  }

  SessionManagerUtil._();

  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    return _preferences.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {

    return _preferences.setString(key, value);
  }

  // get int
  static int getInt(String key, {int defValue = 0}) {
    if (_preferences == null) return defValue;
    return _preferences.getInt(key) ?? defValue;
  }

  // put int
  static Future<bool> putInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  // get double
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_preferences == null) return defValue;
    return _preferences.getDouble(key) ?? defValue;
  }

  // put double
  static Future<bool> putDouble(String key, double value) {
    return _preferences.setDouble(key, value);
  }

  // get bool
  static bool getBoolean(String key, {bool defValue = false}) {
    if (_preferences == null) return defValue;
    return _preferences.getBool(key) ?? defValue;
  }

  // put bool
  static Future<bool> putBoolean(String key, bool value) {

    return _preferences.setBool(key, value);
  }

  static Future<bool> clearAll(){
    return _preferences.clear();
  }
}