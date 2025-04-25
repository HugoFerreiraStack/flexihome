// calendar_page.dart
import 'dart:math';
import 'package:flexihome/src/features/app/domain/entities/event.dart';
import 'package:flexihome/src/features/app/presentations/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  final CalendarController controller = Get.put(CalendarController());
  final DraggableScrollableController _draggableController = DraggableScrollableController();
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    controller.isBottomSheetExpanded.listen((isExpanded) {
      final targetExtent = isExpanded ? 0.85 : 0.35;
      _draggableController.animateTo(
        targetExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      isExpanded ? _iconController.forward() : _iconController.reverse();
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    controller.isBottomSheetExpanded.value = !controller.isBottomSheetExpanded.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendário')),
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  TableCalendar<Event>(
                    locale: 'pt_BR',
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.focusedDay.value,
                    selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
                    calendarFormat: controller.calendarFormat.value,
                    eventLoader: controller.getEventsForDay,
                    onDaySelected: controller.onDaySelected,
                    onFormatChanged: controller.onFormatChanged,
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            bottom: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '${events.length}',
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  // Anima a seta com base no extent (entre 0.2 e 0.85)
                  final percent = ((notification.extent - 0.2) / (0.85 - 0.2)).clamp(0.0, 1.0);
                  _iconController.value = percent;

                  // Atualiza o estado para manter coerência no toggle (caso queira expandir/contrair via código depois)
                  controller.isBottomSheetExpanded.value = notification.extent > 0.5;

                  return true;
                  },
                  child: Obx(() => DraggableScrollableSheet(
                        controller: _draggableController,
                        initialChildSize: controller.isBottomSheetExpanded.value ? 0.85 : 0.35,
                        minChildSize: 0.2,
                        maxChildSize: 0.85,
                        builder: (_, scrollController) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE0EAF7),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: _toggleExpand,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: AnimatedBuilder(
                                      animation: _iconController,
                                      builder: (_, __) => Transform.rotate(
                                        angle: _iconController.value * pi,
                                        child: Icon(Icons.keyboard_arrow_up, size: 28),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  '${controller.selectedDay.value.day.toString().padLeft(2, '0')} de ${_monthName(controller.selectedDay.value.month)} de ${controller.selectedDay.value.year}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    controller: scrollController,
                                    itemCount: controller.getEventsForDay(controller.selectedDay.value).length,
                                    itemBuilder: (context, index) {
                                      final event = controller.getEventsForDay(controller.selectedDay.value)[index];
                                      final color = _getStatusColor(event.status);
                                      final icon = _getStatusIcon(event.status);
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: color,
                                          child: Icon(icon, color: Colors.white),
                                        ),
                                        title: Text(event.title),
                                        subtitle: Text('${event.time} - ${event.status}\nUnidade: ${event.unidade}'),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                ),

              // Obx(() => DraggableScrollableSheet(
              //       controller: _draggableController,
              //       initialChildSize: controller.isBottomSheetExpanded.value ? 0.85 : 0.35,
              //       minChildSize: 0.2,
              //       maxChildSize: 0.85,
              //       builder: (_, scrollController) {
              //         return Container(
              //           decoration: BoxDecoration(
              //             color: Color(0xFFE0EAF7),
              //             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              //           ),
              //           child: Column(
              //             children: [
              //               GestureDetector(
              //                 onTap: _toggleExpand,
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(12.0),
              //                   child: AnimatedBuilder(
              //                     animation: _iconController,
              //                     builder: (_, __) => Transform.rotate(
              //                       angle: _iconController.value * pi,
              //                       child: Icon(Icons.keyboard_arrow_up, size: 28),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //               Text(
              //                 '${controller.selectedDay.value.day.toString().padLeft(2, '0')} de ${_monthName(controller.selectedDay.value.month)} de ${controller.selectedDay.value.year}',
              //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              //               ),
              //               Expanded(
              //                 child: ListView.builder(
              //                   controller: scrollController,
              //                   itemCount: controller.getEventsForDay(controller.selectedDay.value).length,
              //                   itemBuilder: (context, index) {
              //                     final event = controller.getEventsForDay(controller.selectedDay.value)[index];
              //                     final color = _getStatusColor(event.status);
              //                     final icon = _getStatusIcon(event.status);
              //                     return ListTile(
              //                       leading: CircleAvatar(
              //                         backgroundColor: color,
              //                         child: Icon(icon, color: Colors.white),
              //                       ),
              //                       title: Text(event.title),
              //                       subtitle: Text('${event.time} - ${event.status}\nUnidade: ${event.unidade}'),
              //                     );
              //                   },
              //                 ),
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //     )),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.openOverlayScreen,
        child: Icon(Icons.add),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Concluído':
        return Colors.green;
      case 'Em progresso':
        return Colors.orange;
      case 'Pendente':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Concluído':
        return Icons.check_circle;
      case 'Em progresso':
        return Icons.timelapse;
      case 'Pendente':
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_outline;
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
      'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro'
    ];
    return months[month];
  }
}
