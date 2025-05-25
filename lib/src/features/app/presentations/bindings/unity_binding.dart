import 'package:flexihome/src/features/app/presentations/controllers/unity_controller.dart';
import 'package:get/get.dart';

class UnityBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<UnityController>(UnityController());
  }
}
