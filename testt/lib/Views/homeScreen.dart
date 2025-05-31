import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';
import 'package:testt/Widgets/taskTile.dart';

class HomeScreen extends StatelessWidget {
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(child: Text('No tasks added yet.'));
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return TaskTile(
                task: task,
                onToggleDone: () {
                    final updatedTask = TaskModel(
                    id: task.id,
                    title: task.title,
                    description: task.description,
                    date: task.date,
                    isDone: !task.isDone, // toggle the status
                    );
                   taskController.updateTask(updatedTask);
                },
              );
          },
        );
      })
    );
  }
}
