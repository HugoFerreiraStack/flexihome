import 'package:flexihome/src/features/app/domain/entities/endereco.dart';

class Condominio {
  late  String? id;
  late  String? name;
  late  Endereco? endereco;

  Condominio({
     this.id,
     this.name,
     this.endereco,
  });

  factory Condominio.fromJson(Map<String, dynamic> json) {
    return Condominio(
      id: json['id'],
      name: json['name'],
      endereco: Endereco.fromJson(json['endereco']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'endereco': endereco?.toJson()};
  }
}
