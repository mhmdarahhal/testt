
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';

void showDeleteDialog(BuildContext context, int id) {

  final TaskController taskController = Get.find();

    showDialog(
      context: context,
      builder: (context) =>
      AlertDialog(
        title: Text('Delete Task'),
        content: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: Center(
            child: Text(
              'Are you sure you want to delete this task? This action cannot be undone.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              taskController.deleteTask(id);
              Get.back();
            },
            child: Text('Delete Task'),
          ),
        ],
      ),
    );
}