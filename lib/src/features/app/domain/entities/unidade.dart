import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';

class Unidade {
  String? id;
  Endereco? endereco;
  Condominio? condominio;
  String? idImobiliaria;
  String? idHost;
  int? qtdQuartos;
  int? qtdBanheiros;

  Unidade({
    this.id,
    this.endereco,
    this.condominio,
    this.idImobiliaria,
    this.idHost,
    this.qtdQuartos,
    this.qtdBanheiros,
  });

  factory Unidade.fromJson(Map<String, dynamic> json) {
    return Unidade(
      id: json['id'],
      endereco: Endereco.fromJson(json['endereco']),
      condominio: Condominio.fromJson(json['condominio']),
      idImobiliaria: json['idImobiliaria'],
      idHost: json['idHost'],
      qtdBanheiros: json['qtdBanheiros'],
      qtdQuartos: json['qtdQuartos'],
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
    };
  }
}
