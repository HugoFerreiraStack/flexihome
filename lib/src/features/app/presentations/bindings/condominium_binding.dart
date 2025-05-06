import 'package:flexihome/src/features/app/presentations/controllers/condominium_controller.dart';
import 'package:get/get.dart';

class CondominiumBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CondominiumController>(CondominiumController());
  }
}
