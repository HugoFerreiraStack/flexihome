class InfoCep {
  InfoCep({
     this.cep,
     this.logradouro,
     this.complemento,
     this.bairro,
     this.localidade,
     this.uf,
  });
    String? cep;
    String? logradouro;
    String? complemento;
    String? bairro;
    String? localidade;
    String? uf;
  
  InfoCep.fromJson(Map<String, dynamic> json){
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cep'] = cep;
    _data['logradouro'] = logradouro;
    _data['complemento'] = complemento;
    _data['bairro'] = bairro;
    _data['localidade'] = localidade;
    _data['uf'] = uf;
    return _data;
  }
}