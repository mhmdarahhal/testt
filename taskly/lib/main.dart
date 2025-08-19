import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testt/Bindings/BIndings.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Views/navigation.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite ffi for desktop (Windows/Mac/Linux) or tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Now put your GetX controller and run the app
  Get.put(TaskController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Taskly',
      initialBinding: InitialBinding(),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}