import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';
import 'package:sprints_user_profile_management/screens/user_details_screen.dart';

class CardList extends StatelessWidget {
  final Employee employee;
  const CardList({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.width * 0.03), // نسبة من العرض
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: MediaQuery.of(context).size.width * 0.005,
            blurRadius: MediaQuery.of(context).size.width * 0.02,
            offset: Offset(0, MediaQuery.of(context).size.height * 0.005),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: MediaQuery.of(context).size.width * 0.06,
          child: Text(
            employee.name[0],
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          employee.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.045,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          "${employee.id} • ${employee.username}",
          style: TextStyle(
            color: Colors.grey,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.more_vert,
            size: MediaQuery.of(context).size.width * 0.06,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => UserDetailsScreen(
                          employee: employee,
                        )));
          },
        ),
      ),
    );
  }
}
