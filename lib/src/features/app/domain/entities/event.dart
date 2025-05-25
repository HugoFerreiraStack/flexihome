// event.dart
import 'package:flexihome/src/features/app/domain/entities/agendamento_type_enum.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';

class Event {
  String? id;
  AgendamentoTypeEnum? type;
  DateTime? date;
  List<DateTime>? dates;
  Condominio? condominium;
  Unidade? unit;
  String? repeatOption;

  Event({
    this.id,
    this.type,
    this.date,
    this.dates,
    this.condominium,
    this.repeatOption,
    this.unit,
  });

  Event copyWith({
    AgendamentoTypeEnum? type,
    DateTime? date,
    List<DateTime>? dates,
    Condominio? condominium,
    Unidade? unit,
    String? repeatOption,
    String? id,
  }) {
    return Event(
      id: id ?? this.id,
      type: type ?? this.type,
      date: date ?? this.date,
      dates: dates ?? this.dates,
      condominium: condominium ?? this.condominium,
      unit: unit ?? this.unit,
      repeatOption: repeatOption ?? this.repeatOption,
    );
  }

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = agendamentoEnumFromJson(json['type']);
    date = DateTime.parse(json['date']);
    dates = (json['dates'] as List<dynamic>)
        .map((e) => DateTime.parse(e.toString()))
        .toList();
    condominium = Condominio.fromJson(json['condominium']);
    unit = Unidade.fromJson(json['unit']);
    repeatOption = json['repeatOption'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type?.name,
      'date': date?.toIso8601String(),
      'dates': dates?.map((e) => e.toIso8601String()).toList(),
      'condominium': condominium?.toJson(),
      'unit': unit?.toJson(),
      'repeatOption': repeatOption,
    };
  }
}
