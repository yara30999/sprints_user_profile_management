import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';

class EditUserScreen extends StatelessWidget {
  final Employee employee;
  const EditUserScreen({super.key, required this.employee});

  /*
      very similar to add user screen 
      1 create fields that take user input but (the fields have to contain the current data)
      2 save these inputs to Employee object 
      3 call editEmployee() method from ApiService
      4 show snack bar after editing then pop to navigate back to home
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit User screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text('this is Edit User Screen'),
      ),
    );
  }
}
