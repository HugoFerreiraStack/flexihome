import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/app/domain/entities/register_params.dart';

abstract class RegisterRepository {
  Future<Either<Failure, UserCredential>> registerUser(RegisterParams params);
  Future<Either<Failure, bool>> saveUserData(UserApp params);
  Future<Either<Failure, bool>> sendEmail(String params);
}