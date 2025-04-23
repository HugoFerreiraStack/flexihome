import 'package:flexihome/src/features/app/presentations/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with TickerProviderStateMixin {
  final CalendarController controller = Get.put(CalendarController());
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);
  late AnimationController _iconController;

  @override
  void initState() {
    super.initState();
    _iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _iconController.dispose();
    _isExpanded.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    _isExpanded.value = !_isExpanded.value;
    if (_isExpanded.value) {
      _iconController.forward();
    } else {
      _iconController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendário'),
        actions: [
          PopupMenuButton<CalendarFormat>(
            onSelected: controller.onFormatChanged,
            itemBuilder: (context) => [
              PopupMenuItem(value: CalendarFormat.twoWeeks, child: Text('Quinzenal')),
              PopupMenuItem(value: CalendarFormat.month, child: Text('Mensal')),
              PopupMenuItem(value: CalendarFormat.week, child: Text('Semanal')),
            ],
          ),
        ],
      ),
      body: Obx(() => Stack(
            children: [
              Column(
                children: [
                  TableCalendar<Event>(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: controller.focusedDay.value,
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay.value, day),
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
                                borderRadius: BorderRadius.circular(12),
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
                  Expanded(child: SizedBox()), // Preencher o espaço abaixo do calendário
                ],
              ),
              // Draggable Sheet com controle de altura e animação
              ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, child) {
                  return DraggableScrollableSheet(
                    initialChildSize: isExpanded ? 0.85 : 0.35,
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
                                  builder: (_, child) => Transform.rotate(
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
                                    subtitle: Text('${event.time} - ${event.status}'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
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
