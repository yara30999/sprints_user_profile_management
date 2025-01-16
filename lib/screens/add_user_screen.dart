import 'package:flutter/material.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  /*
      1 create fields that take user input 
      2 save these inputs to Employee object 
      3 call addEmployee() method from ApiService
      4 show snack bar after adding then navigate back pop() 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Add User screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text('this is Add User Screen'),
      ),
    );
  }
}
