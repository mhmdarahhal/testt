import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Widgets/taskTile.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 163, 228),
        title: Text(
         'To-Do List',
         style: TextStyle(
          fontSize: 24,
          color: Colors.black,
         ),
        )
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 144, 115, 190),
        ),
        child: Obx(() {
          if (taskController.tasks.isEmpty) {
            return Center(child: Text('No tasks added yet.'));
          }
          return ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              final task = taskController.tasks[index];
              return TaskTile(task: task);
            },
          );
        }),
      )
    );
  }
}
