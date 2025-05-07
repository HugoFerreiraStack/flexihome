import 'package:flexihome/src/features/app/domain/entities/host.dart';

class RegisterParams {
  final String email;
  final String password;
  final UserApp host;

  RegisterParams({
    required this.email,
    required this.password,
    required this.host,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': password, 'host': host.toJson()};
  }

  factory RegisterParams.fromMap(Map<String, dynamic> map) {
    return RegisterParams(
      email: map['email'],
      password: map['password'],
      host: UserApp.fromJson(map['host']),
    );
  }
}