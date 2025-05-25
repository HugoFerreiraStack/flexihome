enum AgendamentoTypeEnum {
  MANUTENCAO,
  MANUTENCAO_PREVENTIVA,
  MANUTENCAO_CORRETIVA,
  MANUTENCAO_AR_CONDICIONADO,
  LIMPEZA,
  LIMPEZA_RECORRENTE
}

extension AgendamentoTypeEnumExtension on AgendamentoTypeEnum {
  String get description {
    switch (this) {
      case AgendamentoTypeEnum.MANUTENCAO:
        return 'Manutenção';
      case AgendamentoTypeEnum.MANUTENCAO_PREVENTIVA:
        return 'Manutenção Preventiva';
      case AgendamentoTypeEnum.MANUTENCAO_CORRETIVA:
        return 'Manutenção Corretiva';
      case AgendamentoTypeEnum.MANUTENCAO_AR_CONDICIONADO:
        return 'Manutenção Ar Condicionado';
      case AgendamentoTypeEnum.LIMPEZA:
        return 'Limpeza';
      case AgendamentoTypeEnum.LIMPEZA_RECORRENTE:
        return 'Limpeza Recorrente';
    }
  }
}

AgendamentoTypeEnum? agendamentoEnumFromJson(String? type) {
  if (type == null) return null;
  return AgendamentoTypeEnum.values.firstWhere(
    (element) => element.name == type,
    orElse: () => AgendamentoTypeEnum.MANUTENCAO,
  );
}
