import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondominiumController extends GetxController {
  static CondominiumController get to => Get.find();

  final _condominium = Condominio().obs;
  Condominio get condominium => _condominium.value;
  set condominium(Condominio value) => _condominium.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  // Future<void> createEvent(Condominio condominium) async {
  //   AddScheduleController.to.selectedUnit = condominium;
  //   Get.to(() => AddSchedulePage(initialDate: DateTime.now()));
  // }

  Future<void> deleteCondominium(Condominio condominium) async {
    try {
      isLoading = true;
      await FirebaseFirestore.instance
          .collection(Constants.collectionCondominio)
          .doc(condominium.id)
          .delete();
      Get.snackbar('Sucesso', 'Condomínio excluído com sucesso',
          backgroundColor: Colors.green, colorText: Colors.white);
      await RegisterCondominiumController.to.getCondominiums().then(
        (value) {
          isLoading = false;
        },
      );
      Get.offAllNamed(AppRoutes.APP);
    } catch (e) {
      isLoading = false;
      Get.snackbar('Erro', 'Erro ao excluir condomínio: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  getUnitysByIdCondominium(){
    // TODO BUSCAR AS UNIDADES REFERENTES AQUELE CONDOMÍNIO.

    Get.toNamed(AppRoutes.CONDOMINIUM_UNITIES_PAGE);
  }

  @override
  void onInit() {
    condominium = Get.arguments;
    log('condominium: ${condominium.toJson()}');
    super.onInit();
  }
}
