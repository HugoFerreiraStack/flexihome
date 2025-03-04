import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';

abstract class LoginRepository {
  Future<Either<Failure, Host>> getUserData(String params);
}
