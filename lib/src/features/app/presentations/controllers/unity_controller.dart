import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flexihome/src/features/app/presentations/controllers/add_schedule_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/app_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/pages/add_schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnityController extends GetxController {
  static UnityController get to => Get.find();

  final _unity = Unidade().obs;
  Unidade get unity => _unity.value;
  set unity(Unidade value) => _unity.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  Future<void> createEvent(Unidade unity) async {
    AddScheduleController.to.selectedUnit = unity;
    Get.to(() => AddSchedulePage(initialDate: DateTime.now()));
    AppController.to.getCondominiums();
    AppController.to.getUnities();
    AppController.to.getEvents();
  }

  Future<void> deleteUnity(Unidade unity) async {
    try {
      isLoading = true;
      await FirebaseFirestore.instance
          .collection(Constants.collectionUnidade)
          .doc(unity.id)
          .delete();
      Get.snackbar('Sucesso', 'Unidade excluída com sucesso',
          backgroundColor: Colors.green, colorText: Colors.white);
      await RegisterUnityController.to.getUnitys().then(
        (value) {
          isLoading = false;
          Get.back();
        },
      );
    } catch (e) {
      isLoading = false;
      Get.snackbar('Erro', 'Erro ao excluir unidade: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onInit() {
    unity = Get.arguments;
    log('unity: ${unity.toJson()}');
    super.onInit();
  }
}
