import 'package:flexihome/src/features/app/domain/entities/endereco.dart';

class Condominio {
  late final String id;
  late final String name;
  late final Endereco endereco;

  Condominio({
    required this.id,
    required this.name,
    required this.endereco,
  });

  factory Condominio.fromJson(Map<String, dynamic> json) {
    return Condominio(
      id: json['id'],
      name: json['name'],
      endereco: Endereco.fromJson(json['endereco']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'endereco': endereco.toJson()};
  }
}
