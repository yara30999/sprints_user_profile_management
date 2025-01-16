import 'package:flutter/material.dart';
import 'package:sprints_user_profile_management/screens/home_screen.dart';
import 'package:sprints_user_profile_management/services/shared_prefs_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sprints Users CRUD Operations',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
