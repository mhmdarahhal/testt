import 'package:flutter/material.dart';
import 'package:testt/Models/TaskModel.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  
  var onToggleDone;

  TaskTile({required this.task, required this.onToggleDone, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title, style: TextStyle(decoration: task.isDone ? TextDecoration.lineThrough : null)),
      subtitle: Text(task.description),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(task.date),
          GestureDetector(
            onTap: onToggleDone,
            child: Icon(task.isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: task.isDone ? Colors.green : Colors.grey)),
        ],
      ),
    );
  }
}