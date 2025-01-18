import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';

class EditUserScreen extends StatelessWidget {
  final Employee employee;
  final Future<bool> Function(Employee)? editEmployee;
  final void Function()? onDone;

  final _formKey = GlobalKey<FormState>();
  late final _idController =
      TextEditingController(text: employee.id.toString());
  late final _usernameController =
      TextEditingController(text: employee.username);
  late final _fullnameController = TextEditingController(text: employee.name);
  late final _zipcodeController =
      TextEditingController(text: employee.address?.zipcode);
  late final _emailController = TextEditingController(text: employee.email);
  late final _phoneController = TextEditingController(text: employee.phone);
  late final _companyNameController =
      TextEditingController(text: employee.company?.name);
  late final _websiteController = TextEditingController(text: employee.website);
  late final _streetController =
      TextEditingController(text: employee.address?.street);
  late final _suiteController =
      TextEditingController(text: employee.address?.suite);
  late final _cityController =
      TextEditingController(text: employee.address?.city);
  late final _catchphraseController =
      TextEditingController(text: employee.company?.catchPhrase);
  late final _bsController = TextEditingController(text: employee.company?.bs);

  EditUserScreen(
      {super.key, required this.employee, this.editEmployee, this.onDone});

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
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Personal Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ID'),
                  controller: _idController,
                  enabled: false,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
                  enabled: false,
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
                Text('Address Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                Text('Company Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                    editEmployee?.call(employee).then((value) {
                      if (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Updated successfully'),
                          ),
                        );
                        onDone?.call();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to update!'),
                          ),
                        );
                      }
                    });
                  },
                  child: Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
