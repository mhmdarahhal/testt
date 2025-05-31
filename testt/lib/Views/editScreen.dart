import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';

class AddEditTaskScreen extends StatefulWidget {
  final TaskModel? task;
  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final TaskController _taskController = Get.find();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descController.text = widget.task!.description;
      _selectedDate = DateFormat('yyyy-MM-dd').parse(widget.task!.date);
    }
  }

  void _submitTask() {
    if (_formKey.currentState!.validate()) {
      final task = TaskModel(
        id: widget.task?.id,
        title: _titleController.text,
        description: _descController.text,
        date: DateFormat('yyyy-MM-dd').format(_selectedDate),
        isDone: widget.task?.isDone ?? false,
      );
      if (widget.task == null) {
        _taskController.addTask(task);
      } else {
        _taskController.updateTask(task);
      }
      Get.back();
      // _titleController.clear();
      // _descController.clear();
      Get.snackbar('Success', widget.task == null ? 'Task added' : 'Task updated');
    }
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.task == null ? 'Add Task' : 'Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a description' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _pickDate,
                    child: Text('Pick Date'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitTask,
                child: Text(widget.task == null ? 'Add Task' : 'Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
