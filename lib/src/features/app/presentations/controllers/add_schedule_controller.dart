// add_schedule_controller.dart
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'calendar_controller.dart';
import '../../domain/entities/event.dart';

class AddScheduleController extends GetxController {
  final titleController = TextEditingController();
  final selectedUnit = ''.obs;
  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;
  final repeatOption = 'Nenhum'.obs;
  final repeatInterval = 1.obs;

  final List<String> unidades = ['unidade1', 'uni2', 'uni3'];
  final List<String> repeatOptions = ['Nenhum', 'Diariamente', 'Semanalmente', 'Mensalmente', 'Anualmente'];

  void setRepeatOption(String value) {
    repeatOption.value = value;
    if (value != 'Mensalmente') {
      repeatInterval.value = 1;
    }
  }

  // void saveSchedule() {
  //   final calendarController = Get.find<CalendarController>();

  //   final newEvent = Event(
  //     titleController.text,
  //     selectedTime.value.format(Get.context!),
  //     repeatOption.value,
  //     selectedUnit.value,
  //   );

  //   calendarController.addEvent(selectedDate.value, newEvent);
  //   Get.back();
  // }

void saveSchedule() {
  final calendarController = Get.find<CalendarController>();

  final String title = titleController.text;
  final String time = selectedTime.value.format(Get.context!);
  final String unidade = selectedUnit.value;
  final String repeat = repeatOption.value;
  final int interval = repeatInterval.value;

  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime selected = DateTime(
    selectedDate.value.year,
    selectedDate.value.month,
    selectedDate.value.day,
  );

  // Use selectedDate como ponto de partida, SEMPRE
  DateTime startDate = selected.isBefore(today) ? today : selected;

  List<DateTime> datesToAdd = [];

  DateTime nextValidDate(int year, int month, int day) {
    try {
      return DateTime(year, month, day);
    } catch (_) {
      final lastDay = DateTime(year, month + 1, 0).day;
      return DateTime(year, month, lastDay);
    }
  }

  switch (repeat) {
    case 'Nenhum':
      datesToAdd.add(startDate);
      break;

    case 'Diariamente':
      for (int i = 0; i < 30; i++) {
        final date = startDate.add(Duration(days: i));
        datesToAdd.add(date);
      }
      break;

    case 'Semanalmente':
      DateTime date = startDate;
      final targetWeekday = selected.weekday;

      // Avança para o próximo dia da semana correspondente
      while (date.weekday != targetWeekday) {
        date = date.add(Duration(days: 1));
      }

      final endDate = startDate.add(Duration(days: 360));
      while (!date.isAfter(endDate)) {
        datesToAdd.add(date);
        date = date.add(Duration(days: 7));
      }
      break;

    case 'Mensalmente':
      DateTime date = nextValidDate(startDate.year, startDate.month, selected.day);
      final endDate = DateTime(startDate.year + 3, startDate.month, 1);

      while (!date.isAfter(endDate)) {
        datesToAdd.add(date);
        final nextMonth = DateTime(date.year, date.month + interval, 1);
        date = nextValidDate(nextMonth.year, nextMonth.month, selected.day);
      }
      break;

    case 'Anualmente':
      for (int i = 0; i < 3; i++) {
        final date = nextValidDate(startDate.year + i, selected.month, selected.day);
        if (!date.isBefore(startDate)) {
          datesToAdd.add(date);
        }
      }
      break;
  }

  for (var date in datesToAdd) {
    final event = Event(title, time, repeat, unidade);
    calendarController.addEvent(date, event);
  }

  calendarController.refreshEvents();
  Get.back();
}


}
