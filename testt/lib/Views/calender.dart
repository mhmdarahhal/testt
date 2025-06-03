import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Controllers/calenderController.dart';
import 'package:testt/Widgets/taskTile.dart';


class CalendarScreen extends StatelessWidget{

  CalendarScreen({super.key});

  final calenderController cc = Get.put(calenderController());
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 188, 163, 228),
        title: Text(
         'Calender',
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
        child: Column(
          children: [
            Obx((){
              return TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: cc.focusedDay.value,
                selectedDayPredicate: (day) => isSameDay(cc.selectedDay.value, day),
                onDaySelected: (selectedDay, focusedDay) {
                    cc.selectedDay.value = selectedDay;
                    cc.focusedDay.value = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                ),
              );
            }),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                final tasks = cc.getTasksForDay(cc.selectedDay.value);
                if (tasks.isEmpty) {
                  return Center(child: Text('No tasks for this day'));
                }
                return ListView.builder(
                  itemCount: taskController.tasks.length,
                  itemBuilder: (context, index) {
                  final task = taskController.tasks[index];
                  return TaskTile(task: task);
                  },
                );
                // return ListView.builder(
                //   itemCount: tasks.length,
                //   itemBuilder: (context, index) {
                //     final task = tasks[index];
                //     return ListTile(
                //       title: Text(task.title),
                //       subtitle: Text(task.description),
                //       trailing: Icon(
                //         task.isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                //         color: task.isDone ? Colors.green : Colors.grey,
                //       ),
                //     );
                //   },
                // );
              }),
            )
          ],
        ),
      ),
    );
  }
}
