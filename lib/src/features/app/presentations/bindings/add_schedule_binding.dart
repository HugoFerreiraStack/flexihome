import 'package:flexihome/src/features/app/presentations/controllers/add_schedule_controller.dart';
import 'package:get/get.dart';

class AddScheduleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddScheduleController>(AddScheduleController());
  }
}
