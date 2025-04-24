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
  final DateTime initialDate = selectedDate.value;
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime baseDate = initialDate.isBefore(today) ? today : initialDate;

  List<DateTime> datesToAdd = [];

  switch (repeat) {
    case 'Nenhum':
      datesToAdd.add(baseDate);
      break;

    case 'Diariamente':
      for (int i = 0; i < 30; i++) {
        final date = baseDate.add(Duration(days: i));
        datesToAdd.add(date);
      }
      break;

    case 'Semanalmente':
      DateTime date = baseDate;
      final targetWeekday = initialDate.weekday;
      final endDate = baseDate.add(Duration(days: 360));

      while (date.isBefore(endDate)) {
        if (date.weekday == targetWeekday) {
          datesToAdd.add(date);
        }
        date = date.add(Duration(days: 1));
      }
      break;

    case 'Mensalmente':
      DateTime date = DateTime(baseDate.year, baseDate.month, initialDate.day);
      final endDate = DateTime(baseDate.year + 3, baseDate.month, baseDate.day);

      while (date.isBefore(endDate)) {
        if (date.isAfter(today) || date.isAtSameMomentAs(today)) {
          datesToAdd.add(date);
        }
        date = DateTime(date.year, date.month + interval, date.day);
      }
      break;

    case 'Anualmente':
      for (int i = 0; i < 3; i++) {
        final date = DateTime(baseDate.year + i, initialDate.month, initialDate.day);
        if (date.isAfter(today) || date.isAtSameMomentAs(today)) {
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
