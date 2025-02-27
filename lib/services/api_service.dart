import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sprints_user_profile_management/models/employee.dart';
import 'package:sprints_user_profile_management/services/shared_prefs_service.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _url = 'https://jsonplaceholder.typicode.com/users';

  Future<bool> _isConnected() async {
    return await InternetConnectionChecker.instance.hasConnection;
  }

  Future<List<Employee>> getEmployees() async {
    if (!await _isConnected()) {
      throw Exception('No internet connection');
    }
    try {
      final response = await _dio.get(_url);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final employees = data.map((json) => Employee.fromJson(json)).toList();
        //then save the employee list to cache
        await AppPreferences.cacheEmployees(response.data);
        return employees;
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }

  Future<Employee> addEmployee(Employee employee) async {
    if (!await _isConnected()) {
      throw Exception('No internet connection');
    }
    try {
      final response = await _dio.post(
        _url,
        data: employee.toJson(),
      );
      if (response.statusCode == 201) {
        return Employee.fromJson(response.data);
      } else {
        throw Exception('Failed to add employee');
      }
    } catch (e) {
      throw Exception('Error adding employee: $e');
    }
  }

  Future<Employee> updateEmployee(Employee employee) async {
    if (!await _isConnected()) {
      throw Exception('No internet connection');
    }
    try {
      final response = await _dio.put(
        '$_url/${employee.id}',
        data: employee.toJson(),
      );
      if (response.statusCode == 200) {
        return Employee.fromJson(response.data);
      } else {
        throw Exception('Failed to update employee');
      }
    } catch (e) {
      throw Exception('Error updating employee: $e');
    }
  }

  Future<void> deleteEmployee(int id) async {
    if (!await _isConnected()) {
      throw Exception('No internet connection');
    }
    try {
      final response = await _dio.delete('$_url/$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception('Failed to delete employee');
      }
    } catch (e) {
      throw Exception('Error deleting employee: $e');
    }
  }
}
