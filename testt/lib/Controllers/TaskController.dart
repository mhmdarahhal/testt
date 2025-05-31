import 'package:get/get.dart';
import 'package:testt/Models/TaskModel.dart';
import 'package:testt/Services/db.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  final DBService _dbService = DBService();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() async {
    final data = await _dbService.getTasks();
    tasks.assignAll(data);
  }

  void addTask(TaskModel task) async {
    await _dbService.insertTask(task);
    loadTasks();
  }

  void updateTask(TaskModel task) async {
    await _dbService.updateTask(task);
    loadTasks();
  }

  void deleteTask(int id) async {
    await _dbService.deleteTask(id);
    loadTasks();
  }
}