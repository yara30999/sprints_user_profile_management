import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';

class AddUserScreen extends StatelessWidget {
  final Future<bool> Function(Employee)? addEmployee;
  final void Function()? onDone;
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _usernameController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _streetController = TextEditingController();
  final _suiteController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _catchphraseController = TextEditingController();
  final _bsController = TextEditingController();
  AddUserScreen({super.key, this.addEmployee, this.onDone});

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
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Personal Details'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ID'),
                  controller: _idController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ID may not be empty!';
                    }
                    if (int.tryParse(value) == null) {
                      return 'ID may be a valid integer!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username may not be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Full Name'),
                  controller: _fullnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name may not be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: _emailController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone'),
                  controller: _phoneController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Website'),
                  controller: _websiteController,
                ),
                Text('Address Details'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Street'),
                  controller: _streetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street may not be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Suite'),
                  controller: _suiteController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'City'),
                  controller: _cityController,
                ),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Zipcode'),
                    controller: _zipcodeController),
                Text('Company Details'),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company Name'),
                  controller: _companyNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Company Name may not be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Catch Phrase'),
                  controller: _catchphraseController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Catch Phrase may not be empty!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'BS'),
                  controller: _bsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'BS may not be empty!';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    Employee employee = Employee(
                        id: int.parse(_idController.text),
                        name: _fullnameController.text,
                        username: _usernameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        website: _websiteController.text,
                        address: Address(
                          street: _streetController.text,
                          suite: _suiteController.text,
                          city: _cityController.text,
                          zipcode: _zipcodeController.text,
                        ),
                        company: Company(
                            name: _companyNameController.text,
                            catchPhrase: _catchphraseController.text,
                            bs: _bsController.text));
                    addEmployee?.call(employee).then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User added successfully!'),
                          ),
                        );
                        onDone?.call();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to add user!'),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Add User'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
