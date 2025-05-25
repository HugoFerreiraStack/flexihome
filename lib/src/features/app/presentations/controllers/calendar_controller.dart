// calendar_controller.dart

import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/features/app/domain/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DraggableScrollableController draggableController =
      DraggableScrollableController();
  late AnimationController iconController;

  final _isAnimating = false.obs;
  bool get isAnimating => _isAnimating.value;
  set isAnimating(bool value) => _isAnimating.value = value;

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
    Get.toNamed(AppRoutes.ADD_SCHEDULE);
  }

  void addEvent(DateTime date, Event event) {
    final normalized = DateTime.utc(date.year, date.month, date.day);
    if (events.containsKey(normalized)) {
      events[normalized]!.add(event);
    } else {
      events[normalized] = [event];
    }
    update(); // Atualiza o Obx
    selectedDay.value = DateTime.now();
    focusedDay.value = DateTime.now();

    //isBottomSheetExpanded.value = true; // Força expansão após salvar
  }

  void refreshEvents() {
    // Isso vai forçar o Obx no calendário a ser atualizado
    selectedDay.refresh();
  }

  void start() {
    iconController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      draggableController.jumpTo(0.35); // Define o estado inicial como fechado
      isBottomSheetExpanded.value =
          false; // Garante que o estado inicial seja fechado
      update();
    });
    isBottomSheetExpanded.listen((isExpanded) {
      if (isAnimating) return; // Evita ciclos durante a animação

      final targetExtent = isExpanded ? 0.9 : 0.35;
      isAnimating = true; // Marca que a animação está em andamento
      draggableController
          .animateTo(
        targetExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      )
          .then((_) {
        isAnimating = false; // Marca que a animação terminou
      });

      if (isExpanded) {
        iconController.forward();
      } else {
        iconController.reverse();
      }
    });
  }

  void toggleExpand() {
    isBottomSheetExpanded.value = !isBottomSheetExpanded.value;
  }

  @override
  void onInit() {
    start();
    super.onInit();
  }

  @override
  void onClose() {
    iconController.dispose();
    super.onClose();
  }
}
