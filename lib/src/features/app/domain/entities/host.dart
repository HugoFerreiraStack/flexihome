import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/features/app/domain/entities/user_type_enum.dart';

class UserApp {
  UserApp(
      {this.blocked,
      this.email,
      this.id,
      this.name,
      this.phone,
      this.cnpj,
      this.fantasyName,
      this.socialReason,
      this.userType,
      this.corretores,
      this.expirationDate});
  bool? blocked;
  String? email;
  String? id;
  String? name;
  String? phone;
  String? cnpj;
  String? fantasyName;
  String? socialReason;
  UserTypeEnum? userType;
  Timestamp? expirationDate;
  List<String>? corretores;

  UserApp.fromJson(Map<String, dynamic> json) {
    expirationDate = json['expirationDate'];
    blocked = json['blocked'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    cnpj = json['cnpj'];
    fantasyName = json['fantasyName'];
    socialReason = json['socialReason'];
    userType = userTypeEnumFromJson(json['userType']);
    if (json['corretores'] != null) {
      corretores = <String>[];
      json['corretores'].forEach((v) {
        corretores!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['blocked'] = blocked;
    _data['email'] = email;
    _data['id'] = id;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['cnpj'] = cnpj;
    _data['fantasyName'] = fantasyName;
    _data['socialReason'] = socialReason;
    _data['userType'] = userType!.name;
    _data['expirationDate'] = expirationDate;
    if (corretores != null) {
      _data['corretores'] = corretores!.map((v) => v).toList();
    }else{ 
      _data['corretores'] = [];
    }

    return _data;
  }
}
