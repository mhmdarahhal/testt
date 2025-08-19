import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Views/calender.dart';
import 'package:testt/Views/editScreen.dart';
import 'package:testt/Views/homeScreen.dart';
import 'package:testt/Views/statistics.dart';


class MainScreen extends StatelessWidget {

  MainScreen({super.key});

  final TaskController taskController = Get.put(TaskController());


  final List<Widget> screens = [
    HomeScreen(),
    AddEditTaskScreen(),
    StatisticsScreen(),
    CalendarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        body: screens[taskController.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 188, 163, 228),
          currentIndex: taskController.currentIndex.value,
          onTap: (index) => taskController.navigateIndex(index),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.add_task), label: 'Add'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          ],
        ),
      );
    });
  }
}