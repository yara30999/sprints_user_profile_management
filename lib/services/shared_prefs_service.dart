import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprints_user_profile_management/models/employee.dart';

const String prefsKeyCachedEmployees = "cachedEmployeesKey";

abstract class AppPreferences {
  static late final SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> cacheEmployees(List<dynamic> employees) async {
    _sharedPreferences.setString(
        prefsKeyCachedEmployees, jsonEncode(employees));
  }

  static Future<List<Employee>> loadCachedEmployees() async {
    final cachedData = _sharedPreferences.getString(prefsKeyCachedEmployees);
    if (cachedData != null) {
      final List<dynamic> data = jsonDecode(cachedData);
      return data.map((json) => Employee.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> clearCachedEmployees() async {
    await _sharedPreferences.remove(prefsKeyCachedEmployees);
  }
}
