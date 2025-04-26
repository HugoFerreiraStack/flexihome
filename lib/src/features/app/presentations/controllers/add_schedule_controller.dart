// controllers/add_schedule_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/event.dart';
import 'calendar_controller.dart';
import '../widgets/error_dialog.dart';
import '../widgets/end_date_dialog.dart';

class AddScheduleController extends GetxController {
  final titleController = TextEditingController();
  final selectedUnit = ''.obs;
  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;
  final repeatOption = ''.obs;
  final endOption = ''.obs;
  final endDate = Rxn<DateTime>();

  final List<String> unidades = ['unidade1', 'uni2', 'uni3'];
  final List<String> endOptions = ['Nunca', 'Na data...'];

  final repeatOptions = <String>[].obs;
  bool get isSingleDateOnly =>
      repeatOption.value.startsWith('Somente');

  @override
  void onInit() {
    super.onInit();
    _buildRepeatOptions();
  }

  void _buildRepeatOptions() {
    final date = selectedDate.value;
    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    repeatOptions.assignAll([
      'Somente $formattedDate',
      'Todos os Dias',
      'Todas as Semanas',
      'A cada 2 Semanas',
      'Todos os Meses',
      'Todos os Anos',
    ]);

    repeatOption.value = repeatOptions.first;
  }

  void setRepeatOption(String value) {
    repeatOption.value = value;
    if (isSingleDateOnly) {
      endOption.value = '';
      endDate.value = null;
    }
  }

  void setEndOption(String value) {
    endOption.value = value;
    if (value == 'Nunca') {
      endDate.value = null;
    }
  }

  Future<void> pickEndDate() async {
    final maxSelectableDate =
        selectedDate.value.add(Duration(days: 365 * 3 + 60)); // 3 anos + 2 meses

    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: selectedDate.value,
      lastDate: maxSelectableDate,
    );

    if (picked != null) {
      // Validação específica
      if (repeatOption.value == 'Todos os Dias' &&
          picked.isAfter(selectedDate.value.add(Duration(days: 95)))) {
        showErrorDialog(
            'Eventos diários podem ser agendados no máximo para 95 dias.');
        return;
      }

      final limitForValidation =
          selectedDate.value.add(Duration(days: 365 * 3)); // 3 anos "visuais"
      if (picked.isAfter(limitForValidation)) {
        showErrorDialog(
            'Eventos podem ser agendados no máximo para 3 anos.');
        return;
      }

      final confirmed = await showEndDateDialog(
        titleController.text.isEmpty ? 'Agendamento' : titleController.text,
        repeatOption.value,
        picked,
      );

      if (confirmed) {
        endDate.value = picked;
      }
    }
  }

  void saveSchedule() {
    final calendarController = Get.find<CalendarController>();

    if (titleController.text.trim().isEmpty ||
        selectedUnit.value.isEmpty ||
        repeatOption.value.isEmpty ||
        (!isSingleDateOnly && endOption.value.isEmpty)) {
      showErrorDialog('Preencha todos os campos obrigatórios.');
      return;
    }

    final String title = titleController.text.trim();
    final String time = selectedTime.value.format(Get.context!);
    final String unidade = selectedUnit.value;
    final String repeat = repeatOption.value;

    DateTime startDate = selectedDate.value;
    DateTime? limitDate;

    // Regras para limite de data
    if (isSingleDateOnly) {
      limitDate = startDate;
    } else if (endOption.value == 'Nunca') {
      if (repeat == 'Todos os Dias') {
        limitDate = startDate.add(Duration(days: 95));
      } else {
        limitDate = startDate.add(Duration(days: 365 * 3 + 60));
      }
    } else if (endOption.value == 'Na data...' && endDate.value != null) {
      if (repeat == 'Todos os Dias' &&
          endDate.value!.isAfter(startDate.add(Duration(days: 95)))) {
        showErrorDialog(
            'Eventos diários podem ser agendados no máximo para 95 dias.');
        return;
      }

      if (endDate.value!.isAfter(startDate.add(Duration(days: 365 * 3 + 60)))) {
        showErrorDialog(
            'Eventos podem ser agendados no máximo para 3 anos.');
        return;
      }

      limitDate = endDate.value;
    } else {
      showErrorDialog('Selecione uma data final válida.');
      return;
    }

    // Gerar lista de datas
    List<DateTime> datesToAdd = [];

    DateTime nextValidDate(int year, int month, int day) {
      try {
        return DateTime(year, month, day);
      } catch (_) {
        final lastDay = DateTime(year, month + 1, 0).day;
        return DateTime(year, month, lastDay);
      }
    }

    DateTime date = startDate;

    switch (repeat) {
      case 'Todos os Dias':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 1));
        }
        break;
      case 'Todas as Semanas':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 7));
        }
        break;
      case 'A cada 2 Semanas':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 14));
        }
        break;
      case 'Todos os Meses':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = nextValidDate(date.year, date.month + 1, date.day);
        }
        break;
      case 'Todos os Anos':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = DateTime(date.year + 1, date.month, date.day);
        }
        break;
      default:
        // Caso seja "Somente [data]", adiciona só a data selecionada
        datesToAdd.add(startDate);
        break;
    }

    for (var d in datesToAdd) {
      final event = Event(title, time, repeat, unidade);
      calendarController.addEvent(d, event);
    }

    calendarController.refreshEvents();
    Get.back();
  }
}
