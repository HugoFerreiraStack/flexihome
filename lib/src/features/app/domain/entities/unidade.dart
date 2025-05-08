import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';
import 'package:flexihome/src/features/app/domain/entities/event.dart';

class Unidade {
  String? id;
  String? numberAp;
  Endereco? endereco;
  Condominio? condominio;
  String? idImobiliaria;
  String? idHost;
  int? qtdQuartos;
  int? qtdBanheiros;
  String? criadoPor;
  DateTime? criadoEm;
  List<String>? usuarios;
  List<Event>? eventos;
  String? name;

  Unidade(
      {this.id,
      this.endereco,
      this.condominio,
      this.idImobiliaria,
      this.idHost,
      this.qtdQuartos,
      this.qtdBanheiros,
      this.criadoPor,
      this.criadoEm,
      this.usuarios,
      this.numberAp,
      this.eventos,
      this.name});

  factory Unidade.fromJson(Map<String, dynamic> json) {
    return Unidade(
      id: json['id'],
      endereco: Endereco.fromJson(json['endereco']),
      condominio: Condominio.fromJson(json['condominio']),
      idImobiliaria: json['idImobiliaria'],
      idHost: json['idHost'],
      qtdBanheiros: json['qtdBanheiros'],
      qtdQuartos: json['qtdQuartos'],
      criadoPor: json['criadoPor'],
      criadoEm: DateTime.parse(json['criadoEm']),
      numberAp: json['numberAp'],
      usuarios: List<String>.from(json['usuarios'] ?? []),
      eventos: (json['eventos'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e))
          .toList(),
      name: json['endereco'] != null && json['numberAp'] != null
          ? '${Endereco.fromJson(json['endereco']).logradouro} ${json['numberAp']}'
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'endereco': endereco?.toJson(),
      'condominio': condominio?.toJson(),
      'idImobiliaria': idImobiliaria,
      'idHost': idHost,
      'qtdQuartos': qtdQuartos,
      'qtdBanheiros': qtdBanheiros,
      'criadoPor': criadoPor,
      'criadoEm': criadoEm?.toIso8601String(),
      'usuarios': usuarios,
      'numberAp': numberAp,
      'eventos': eventos?.map((e) => e.toJson()).toList(),
    };
  }
}
