import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';


class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final TaskController _taskController = Get.find();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<TaskModel> _getTasksForDay(DateTime day) {
    final String formattedDay = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
    return _taskController.tasks.where((task) => task.date == formattedDay).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              final tasks = _getTasksForDay(_selectedDay ?? _focusedDay);
              if (tasks.isEmpty) {
                return Center(child: Text('No tasks for this day'));
              }
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Icon(
                      task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: task.isDone ? Colors.green : Colors.grey,
                    ),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
