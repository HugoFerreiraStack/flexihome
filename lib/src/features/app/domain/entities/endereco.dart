class Endereco {
  String? cep;
  String? logradouro;
  String? bairro;
  String? cidade;
  String? estado;
  String? complemento;

  Endereco({
    this.cep,
    this.logradouro,
    this.bairro,
    this.cidade,
    this.estado,
    this.complemento,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      logradouro: json['logradouro'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      estado: json['estado'],
      complemento: json['complemento'],
    );
  }

  Endereco.fromCep(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['localidade'];
    estado = json['uf'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'bairro': bairro,
      'cidade': cidade,
      'estado': estado,
      'complemento': complemento,
    };
  }

  @override
  String toString() {
    return 'Endereco(cep: $cep, logradouro: $logradouro, bairro: $bairro, cidade: $cidade, estado: $estado, complemento: $complemento)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Endereco &&
        other.cep == cep &&
        other.logradouro == logradouro &&
        other.bairro == bairro &&
        other.cidade == cidade &&
        other.complemento == complemento &&
        other.estado == estado;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
        logradouro.hashCode ^
        bairro.hashCode ^
        cidade.hashCode ^
        complemento.hashCode ^
        estado.hashCode;
  }
}
