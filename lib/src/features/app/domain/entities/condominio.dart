import 'package:flexihome/src/features/app/domain/entities/endereco.dart';

class Condominio {
  String? id;
  String? nome;
  Endereco? endereco;
  String? cidade;
  String? estado;
  String? criadoPor; // ID do usuário (imobiliária ou corretor) que cadastrou
  List<String>? usuarios; // IDs dos usuários associados
  DateTime? criadoEm;

  Condominio({
    this.id,
    this.nome,
    this.endereco,
    this.cidade,
    this.estado,
    this.criadoPor,
    this.usuarios,
    this.criadoEm,
  });

  factory Condominio.fromJson(Map<String, dynamic> json) {
    return Condominio(
      id: json['id'],
      nome: json['nome'],
      endereco: Endereco.fromJson(json['endereco']),
      cidade: json['cidade'],
      estado: json['estado'],
      criadoPor: json['criadoPor'],
      usuarios: List<String>.from(json['usuarios'] ?? []),
      criadoEm: DateTime.parse(json['criadoEm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'endereco': endereco,
      'cidade': cidade,
      'estado': estado,
      'criadoPor': criadoPor,
      'usuarios': usuarios,
      'criadoEm': criadoEm?.toIso8601String(),
    };
  }
}
