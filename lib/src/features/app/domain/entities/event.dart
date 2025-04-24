// event.dart
class Event {
  final String title;
  final String time;
  final String status;
  final String unidade;

  Event(this.title, this.time, this.status, [this.unidade = '']);
}