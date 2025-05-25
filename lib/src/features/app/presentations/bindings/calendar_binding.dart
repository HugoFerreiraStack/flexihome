import 'package:flexihome/src/features/app/presentations/controllers/calendar_controller.dart';
import 'package:get/get.dart';

class CalendarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CalendarController>(CalendarController());
  }
}
