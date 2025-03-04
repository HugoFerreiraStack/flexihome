enum UserTypeEnum { IMOBILIARIA, ANFITRIAO, }

extension UserTypeEnumExtension on UserTypeEnum {
  String get name {
    switch (this) {
      case UserTypeEnum.IMOBILIARIA:
        return 'Imobiliária';
      case UserTypeEnum.ANFITRIAO:
        return 'Anfitrião';
     
    }
  }
}

UserTypeEnum? userTypeEnumFromJson(String? userType) {
  if (userType == null) return null;
  return UserTypeEnum.values.firstWhere(
    (element) => element.name == userType,
    orElse: () => UserTypeEnum.IMOBILIARIA,
  );
}
