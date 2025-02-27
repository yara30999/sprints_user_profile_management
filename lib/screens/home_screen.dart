import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/models/employee.dart';
import 'package:sprints_user_profile_management/screens/add_user_screen.dart';
import 'package:sprints_user_profile_management/screens/edit_user_screen.dart';
import 'package:sprints_user_profile_management/services/api_service.dart';
import 'package:sprints_user_profile_management/services/shared_prefs_service.dart';
import 'package:sprints_user_profile_management/screens/widgets/card.dart';
import 'package:sprints_user_profile_management/screens/widgets/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<void> refreshEmployees() async {
    await AppPreferences.clearCachedEmployees();
    setState(() {
      getEmployeeData();
    });
  }

  void addEmployee(Employee newEmployee) async {
    // Step 1: Resolve the current list of employees
    List<Employee> currentList = await employees;
    // Step 2: Add the new employee to the list
    currentList.add(newEmployee);
    // Step 3: Update the future with the modified list
    employees = Future.value(currentList);
  }

  void updateEmployee(int id, Employee updatedEmployee) async {
    // Step 1: Resolve the current list of employees
    List<Employee> currentList = await employees;
    // Step 2: Find the index of the employee to update
    int index = currentList.indexWhere((employee) => employee.id == id);
    if (index != -1) {
      // Step 3: Update the employee at the found index
      currentList[index] = updatedEmployee;
      // Step 4: Update the future with the modified list
      employees = Future.value(currentList);
    } else {
      debugPrint('Employee with ID $id not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Employees List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: RefreshIndicator(
        onRefresh: refreshEmployees,
        child: FutureBuilder(
          future: employees,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return ShimmerCard();
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No employees found.'),
              );
            }

            final employeeList = snapshot.data!;
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: employeeList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.001);
              },
              itemBuilder: (context, index) {
                final employee = employeeList[index];
                return Dismissible(
                  key: Key(employee.id.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      await service.deleteEmployee(employee.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${employee.name} deleted successfully',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (direction == DismissDirection.startToEnd) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserScreen(
                            employee: employee,
                            editEmployee: (employee) {
                              return service.updateEmployee(employee).then(
                                (value) {
                                  setState(() {
                                    updateEmployee(employee.id, value);
                                  });
                                  return true;
                                },
                              ).catchError((error) => false);
                            },
                            onDone: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    }
                  },
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: CardList(
                    employee: employee,
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddUserScreen(
                      addEmployee: (employee) {
                        return service.addEmployee(employee).then(
                          (value) {
                            setState(() {
                              addEmployee(value);
                            });
                            return true;
                          },
                        ).catchError((error) => false);
                      },
                      onDone: () {
                        Navigator.pop(context);
                      },
                    )),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
