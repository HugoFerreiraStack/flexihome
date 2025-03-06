import 'package:flexihome/src/features/app/presentations/controllers/app_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(AppController());
  }
}
