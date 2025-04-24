// calendar_controller.dart

import 'package:flexihome/src/features/app/domain/entities/event.dart';
import 'package:flexihome/src/features/app/presentations/pages/add_schedule.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;
  var isBottomSheetExpanded = false.obs;

  final Map<DateTime, List<Event>> events = {};

  List<Event> getEventsForDay(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return events[key] ?? [];
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void openOverlayScreen() {
    Get.to(() => AddSchedulePage(initialDate: selectedDay.value));
  }

  void addEvent(DateTime date, Event event) {
    final normalized = DateTime.utc(date.year, date.month, date.day);
    if (events.containsKey(normalized)) {
      events[normalized]!.add(event);
    } else {
      events[normalized] = [event];
    }
    update(); // Atualiza o Obx
    selectedDay.value = date;
    focusedDay.value = date;
    isBottomSheetExpanded.value = true; // Força expansão após salvar
  }

  void refreshEvents() {
  // Isso vai forçar o Obx no calendário a ser atualizado
  selectedDay.refresh();
}
}
