import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';
import 'package:testt/Widgets/deleteDialog.dart';

class TaskTile extends StatelessWidget {

  final TaskModel task;
  
  final TaskController taskController = Get.find();

  TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title, 
        style: TextStyle(
          decoration: task.isDone ? TextDecoration.lineThrough : null,
          color: Colors.black,
        )
      ),
      subtitle: Text(task.description),
      trailing: SizedBox(
        width: 65,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => taskController.onToggleDone(task),
                child: Icon(task.isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: task.isDone ? Colors.white : const Color.fromARGB(255, 77, 71, 71))
              ),
              IconButton(
                // onPressed: null,
                onPressed:() {
                  if (task.id != null) {
                    showDeleteDialog(context, task.id!);
                  }
                  else {
                    Get.snackbar('Error', 'Task ID is null, cannot delete task.');
                  }
                },
                icon: Icon(Icons.delete, color: const Color.fromARGB(255, 77, 71, 71))
              )
            ],
          ),
      ),
    );
  }
}