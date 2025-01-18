import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';

class UserDetailsScreen extends StatelessWidget {
  final Employee employee;
  const UserDetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    String notFoundMSG = "No data found" ;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          employee.name,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: MediaQuery.of(context).size.width * 0.2,
                  child: Text(
                    employee.name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              customText("Name : ", employee.name),
              customText("Id : ", "${employee.id}"),
              customText("Username : ", employee.username ?? notFoundMSG),
              customText("Email : ", employee.email ?? notFoundMSG),
              customText("Phone : ", employee.phone ?? notFoundMSG), 
              customText("Website : ", employee.website ?? notFoundMSG),
              customText("Address : ", "${employee.address!.street} - ${employee.address!.suite} - ${employee.address!.city}" ),
              customText("ZipCode : ", employee.address!.zipcode ?? notFoundMSG),
              customText("Company : ", "${employee.company!.name } - ${employee.company!.catchPhrase} - ${employee.company!.bs}"),
            ],
          ),
        ),
      ),
    );
  }

  Widget customText(String title, String content) =>
      Text.rich(TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
              //fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.blueGrey,
            )),
        TextSpan(text: content , style: TextStyle(fontSize: 18))
      ]));
}
