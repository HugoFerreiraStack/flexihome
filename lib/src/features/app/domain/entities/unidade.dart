import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';

class Unidade {
  final String id;
  final Endereco endereco;
  final Condominio condominio;

  Unidade({required this.id, required this.endereco, required this.condominio});

  factory Unidade.fromJson(Map<String, dynamic> json) {
    return Unidade(
      id: json['id'],
      endereco: Endereco.fromJson(json['endereco']),
      condominio: Condominio.fromJson(json['condominio']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'endereco': endereco.toJson(),
      'condominio': condominio.toJson(),
    };
  }
}
