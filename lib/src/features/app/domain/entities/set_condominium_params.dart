import 'package:flexihome/src/features/app/domain/entities/condominio.dart';

class SetCondominiumParams {
   Condominio? condominio;
   String? idImobiliaria;
   String? idHost;

  SetCondominiumParams({this.condominio, this.idImobiliaria, this.idHost});

  Map<String, dynamic> toJson() {
    return {
      'condominio': condominio?.toJson(),
      'idImobiliaria': idImobiliaria,
      'idHost': idHost,
    };
  }

  factory SetCondominiumParams.fromJson(Map<String, dynamic> json) {
    return SetCondominiumParams(
      condominio: Condominio.fromJson(json['condominio']),
      idImobiliaria: json['idImobiliaria'],
      idHost: json['idHost'],
    );
  }
}
