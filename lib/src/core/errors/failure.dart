import 'dart:developer';

abstract class Failure implements Exception {
  final String? message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message) {
    if (message != null) log(message.toString());
  }
}

class AppFailure extends Failure {
  AppFailure(String? message) : super(message) {
    log(message.toString(), name: 'AppFailure');
  }
}
