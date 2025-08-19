import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';

class AddTaskController extends GetxController{
  
final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  final TaskController taskController = Get.put(TaskController());

  void submitTask() {
    if (formKey.currentState!.validate()) {
      final task = TaskModel(
       
        title: titleController.text,
        description: descController.text,
        date: DateFormat('yyyy-MM-dd').format(selectedDate.value),
        isDone: false,
      );
      taskController.addTask(task);
      titleController.clear();
      descController.clear();
      Get.back();
      Get.snackbar('Success', 'Task added');
    }
  }

  Future<void> pickDate(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != selectedDate) {
        selectedDate.value = picked!;
    }
  }

}