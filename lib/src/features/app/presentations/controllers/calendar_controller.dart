import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var calendarFormat = CalendarFormat.month.obs;

  // Mapa de eventos simulados (mock), prontos para serem substituídos por dados do banco
  final Map<DateTime, List<Event>> _events = {
    DateTime.utc(2025, 3, 8): [
      Event('Reunião - Genebra, 403', '10:00 - 11:30', 'Concluído'),
      Event('Limpeza - Genebra, 401', '13:00 - 14:30', 'Em progresso'),
    ],
    DateTime.utc(2025, 3, 15): [
      Event('Planejamento Sprint', '09:00 - 10:00', 'Pendente'),
      Event('Revisão QA', '11:00 - 12:00', 'Concluído'),
      Event('Deploy Produção', '15:00 - 16:00', 'Pendente'),
    ],
    DateTime.utc(2025, 3, 30): [
      Event('Relatório Mensal', '08:00 - 09:00', 'Concluído'),
      Event('Call com cliente', '10:30 - 11:30', 'Concluído'),
      Event('Apresentação externa', '14:00 - 15:00', 'Pendente'),
      Event('Entrega documento', '16:00 - 17:00', 'Em progresso'),
    ],
  };

  List<Event> getEventsForDay(DateTime day) {
    final key = DateTime.utc(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
    // openOverlayScreen(); // Abre a tela sobreposta ao clicar na data
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void openOverlayScreen() {
    Get.bottomSheet(
      Container(
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            'Tela sobreposta (aqui pode vir um formulário, etc)',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class Event {
  final String title;
  final String time;
  final String status;

  Event(this.title, this.time, this.status);
}