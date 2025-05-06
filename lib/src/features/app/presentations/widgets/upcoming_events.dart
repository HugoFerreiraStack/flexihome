import 'package:flexihome/src/features/app/domain/entities/event.dart';
import 'package:flutter/material.dart';

class UpcomingEventsList extends StatelessWidget {
  final List<Event> events;

  const UpcomingEventsList({required this.events, super.key});

  @override
  Widget build(BuildContext context) {
    // Ordena os eventos pela data mais próxima
    final upcomingEvents = events
        .where((event) => event.date != null && event.date!.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.date!.compareTo(b.date!));

    if (upcomingEvents.isEmpty) {
      return Center(
        child: Text(
          'Nenhum evento próximo.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: upcomingEvents.length,
      itemBuilder: (context, index) {
        final event = upcomingEvents[index];
        return ListTile(
          leading: Icon(Icons.event, color: Colors.blue),
          title: Text(
            event.type?.name ?? 'Evento',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Data: ${event.date != null ? _formatDate(event.date!) : 'Indefinida'}\n'
            'Condomínio: ${event.condominium?.name ?? 'Desconhecido'}\n'
            'Unidade: ${event.unit?.numberAp ?? 'Desconhecida'}',
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // Ação ao clicar no evento
            print('Evento selecionado: ${event.id}');
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}