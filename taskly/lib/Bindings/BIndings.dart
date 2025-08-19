import 'package:get/get.dart';
import 'package:testt/Controllers/TaskController.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
  }
}