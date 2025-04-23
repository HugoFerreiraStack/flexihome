import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddScheduleController extends GetxController {
  final titleController = TextEditingController();
  final selectedUnit = ''.obs;
  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;

  final repeatOption = ''.obs;
  final repeatInterval = 1.obs;

  final List<String> unidades = ['unidade1', 'uni2', 'uni3'];
  final List<String> repeatOptions = ['Nenhum', 'Diariamente', 'Semanalmente', 'Mensalmente', 'Anualmente'];

  void setRepeatOption(String value) {
    repeatOption.value = value;
    if (value != 'Mensalmente') {
      repeatInterval.value = 1;
    }
  }

  void saveSchedule() {
    // Aqui você pode salvar os dados ou enviar para API, etc
    print('Agendamento salvo:');
    print('Título: ${titleController.text}');
    print('Unidade: ${selectedUnit.value}');
    print('Data: ${selectedDate.value}');
    print('Hora: ${selectedTime.value.format(Get.context!)}');
    print('Repetição: ${repeatOption.value}');
    if (repeatOption.value == 'Mensalmente') {
      print('Intervalo: ${repeatInterval.value} mês(es)');
    }

    Get.back(); // Fecha a tela após salvar
  }
}
