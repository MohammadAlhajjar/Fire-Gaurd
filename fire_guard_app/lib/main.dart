import 'package:fire_guard_app/core/config/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/fire_guard_app.dart';
late SharedPreferences sharedPreferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await setup();
  runApp( FireGuardApp(sharedPreferences: sharedPreferences,));
}
