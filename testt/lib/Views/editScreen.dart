import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testt/Controllers/AddTaskController.dart';


class AddEditTaskScreen extends StatelessWidget {
  
final AddTaskController atc= Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 163, 228),
        title: Text(
         'Add Task',
         style: TextStyle(
          fontSize: 24,
          color: Colors.black,
         ),
        )
      ),
      body: Form(
          key: atc.formKey,
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 144, 115, 190),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: atc.titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
                  ),
                  TextFormField(
                    controller: atc.descController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) => value == null || value.isEmpty ? 'Enter a description' : null,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                     Obx(() => Text('Date: ${DateFormat('yyyy-MM-dd').format(atc.selectedDate.value)}',
                          style: TextStyle(fontSize: 16, color: Colors.black))
                          ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () => atc.pickDate(context),
                        child: Text('Pick Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: atc.submitTask,
                    child: Text( 'Add Task' ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}