import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';
import 'package:sprints_user_profile_management/screens/add_user_screen.dart';
import 'package:sprints_user_profile_management/services/api_service.dart';
import 'package:sprints_user_profile_management/services/shared_prefs_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
      1 create pull to refresh using any package you want
          (when you pull to refresh , two actions will happen first [remove the cache] then [getEmployees() method again]) 
      2 when the app opened you need to call  getEmployees() in initState and show it here in lists
      3 each employee list can swip to right or left , for [delete employee] and [edit employee]
      4 show snack bar after deleting 

      you any packages you want ;) 
  */

  late Future<List<Employee>> employees;
  final ApiService service = ApiService();

  @override
  void initState() {
    super.initState();
    getEmployeeData();
  }

  Future<void> getEmployeeData() async {
    //if the cache is empty call the api
    employees = AppPreferences.loadCachedEmployees().then((cached) {
      if (cached.isNotEmpty) {
        return cached;
      }
      return service.getEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Employees List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text('this is home'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
