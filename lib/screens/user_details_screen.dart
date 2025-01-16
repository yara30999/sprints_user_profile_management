import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        // you can put the user name instead
        // also you can use hero widget here
        // Feel free to customize this screen as you want. Show all the data in the Employee object.
        title: Text(
          'User Details screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text('this is User Details screen'),
      ),
    );
  }
}
