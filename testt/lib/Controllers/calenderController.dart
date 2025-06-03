import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';
import 'package:testt/Models/TaskModel.dart';

class calenderController extends GetxController {

  final TaskController taskController = Get.find<TaskController>();
  
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  List<TaskModel> getTasksForDay(DateTime day) {
    final String formattedDay = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
    return taskController.tasks.where((task) => task.date == formattedDay).toList();
  }
}