import 'package:fire_gurad_dashboard/pages/dash_board_page.dart';
import 'package:fire_gurad_dashboard/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const FireGuardDashBoard());
}

class FireGuardDashBoard extends StatelessWidget {
  const FireGuardDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sharedPreferences.getString('token') != null
          ? const DashboardPage()
          : const LoginPage(),
    );
  }
}
