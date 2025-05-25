
class Condominio {
  String? id;
  String? nome;
  String? logradouro;
  String? bairro;
  String? cep;
  String? cidade;
  String? estado;
  String? numero;
  String? criadoPor; 
  List<String>? usuarios; 
  DateTime? criadoEm;
  int? totalUnitys;
  String? idImobiliaria;

  Condominio({
    this.id,
    this.nome,
    this.cidade,
    this.estado,
    this.criadoPor,
    this.usuarios,
    this.criadoEm,
    this.numero,
    this.logradouro,
    this.bairro,
    this.cep,
    this.totalUnitys,
    this.idImobiliaria,

  });

  factory Condominio.fromJson(Map<String, dynamic> json) {
    return Condominio(
      id: json['id'],
      nome: json['nome'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      cep: json['cep'],
      cidade: json['cidade'],
      estado: json['estado'],
      numero: json['numero'],
      criadoPor: json['criadoPor'],
      usuarios: List<String>.from(json['usuarios'] ?? []),
      criadoEm: DateTime.parse(json['criadoEm']),
      totalUnitys: json['totalUnitys'],
      idImobiliaria: json['idImobiliaria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cidade': cidade,
      'estado': estado,
      'logradouro': logradouro,
      'bairro': bairro,
      'cep': cep,
      'criadoPor': criadoPor,
      'usuarios': usuarios,
      'numero': numero,
      'criadoEm': criadoEm?.toIso8601String(),
      'totalUnitys': totalUnitys,
      'idImobiliaria': idImobiliaria,
    };
  }
}
