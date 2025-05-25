import 'dart:math';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/agendamento_type_enum.dart';
import 'package:flexihome/src/features/app/domain/entities/event.dart';
import 'package:flexihome/src/features/app/presentations/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: controller.openOverlayScreen,
          onLongPress: () => Get.snackbar('Botão', 'Adicionar Agendamento',
              snackPosition: SnackPosition.BOTTOM),
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: AppColors.primary,
              elevation: 4,
              padding: EdgeInsets.all(20)),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.tertiary,
                  AppColors.primary,
                  AppColors.secondary
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 6.0,
                        top: getValueForScreenType(
                          context: context,
                          mobile: 5,
                          tablet: 20,
                          desktop: 20,
                        )),
                    child: Center(
                      child: Text(
                        'Agenda',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          decorationColor: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Obx(() => Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      width: getValueForScreenType(
                                          context: context,
                                          mobile: 100.sw,
                                          tablet: 100.sw,
                                          desktop: 100.sw),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(40),
                                        ),
                                      ),
                                      child: TableCalendar<Event>(
                                        locale: 'pt_BR',
                                        firstDay: DateTime.utc(2020, 1, 1),
                                        lastDay: DateTime.utc(2030, 12, 31),
                                        calendarStyle: CalendarStyle(
                                          weekendDecoration: BoxDecoration(
                                            color: AppColors.secondary
                                                .withAlpha(20),
                                          ),
                                          selectedDecoration: BoxDecoration(
                                              color: AppColors.primary,
                                              shape: BoxShape.circle),
                                          cellMargin: EdgeInsets.zero,
                                        ),
                                        focusedDay: _clampDate(
                                          controller.focusedDay.value,
                                          DateTime.utc(2020, 1, 1),
                                          DateTime.utc(2030, 12, 31),
                                        ),
                                        selectedDayPredicate: (day) =>
                                            isSameDay(
                                                controller.selectedDay.value,
                                                day),
                                        calendarFormat:
                                            controller.calendarFormat.value,
                                        eventLoader: controller.getEventsForDay,
                                        onDaySelected: controller.onDaySelected,
                                        onFormatChanged:
                                            controller.onFormatChanged,
                                        calendarBuilders: CalendarBuilders(
                                          markerBuilder:
                                              (context, date, events) {
                                            if (events.isNotEmpty) {
                                              return Positioned(
                                                bottom: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    '${events.length}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              );
                                            }
                                            return SizedBox();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: SizedBox(
                                width: getValueForScreenType(
                                    context: context,
                                    mobile: 100.sw,
                                    tablet: 100.sw,
                                    desktop: 100.sw),
                                child: NotificationListener<
                                    DraggableScrollableNotification>(
                                  onNotification: (notification) {
                                    final percent =
                                        ((notification.extent - 0.4) /
                                                (0.91 - 0.4))
                                            .clamp(0.0, 1.0);
                                    controller.iconController.value = percent;
                                    controller.isBottomSheetExpanded.value =
                                        notification.extent > 0.4;
                                    return true;
                                  },
                                  child: Obx(() => DraggableScrollableSheet(
                                        controller:
                                            controller.draggableController,
                                        initialChildSize: controller
                                                .isBottomSheetExpanded.value
                                            ? 0.91
                                            : 0.4,
                                        minChildSize: 0.4,
                                        maxChildSize: 0.91,
                                        builder: (_, scrollController) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.quaternary,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(40)),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap:
                                                        controller.toggleExpand,
                                                    child: AnimatedBuilder(
                                                      animation: controller
                                                          .iconController,
                                                      builder: (_, __) =>
                                                          Transform.rotate(
                                                        angle: controller
                                                                .iconController
                                                                .value *
                                                            pi,
                                                        child: Icon(
                                                            Icons
                                                                .keyboard_arrow_up,
                                                            color: Colors.white,
                                                            size: 28),
                                                      ),
                                                    ),
                                                  ),
                                                  Obx(() => Text(
                                                      'Dia selecionado: ${controller.selectedDay.value.day.toString().padLeft(2, '0')} de ${_monthName(controller.selectedDay.value.month)} de ${controller.selectedDay.value.year}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                    )),
                                                  Expanded(
                                                    child: ListView.builder(
                                                      controller:
                                                          scrollController,
                                                      itemCount: controller
                                                          .getEventsForDay(
                                                              controller
                                                                  .selectedDay
                                                                  .value)
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final event = controller
                                                            .getEventsForDay(
                                                                controller
                                                                    .selectedDay
                                                                    .value)[index];

                                                        // final icon =
                                                        //     _getStatusIcon(event.status);
                                                        return ListTile(
                                                          leading: CircleAvatar(
                                                            backgroundColor:
                                                                AppColors
                                                                    .primary,
                                                            child: Icon(
                                                                Icons
                                                                    .calendar_today,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          title: Text(
                                                            '-${event.type?.description} ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          subtitle: Text(
                                                              '${event.unit?.numberAp}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  // Color _getStatusColor(String status) {
  String _monthName(int month) {
    const months = [
      '',
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro'
    ];
    return months[month];
  }
}

DateTime _clampDate(DateTime date, DateTime min, DateTime max) {
  if (date.isBefore(min)) return min;
  if (date.isAfter(max)) return max;
  return date;
}
