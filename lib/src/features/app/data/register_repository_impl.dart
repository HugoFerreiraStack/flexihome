import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/app/domain/entities/register_params.dart';
import 'package:flexihome/src/features/app/domain/repositories/register_user_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  @override
  Future<Either<Failure, UserCredential>> registerUser(
    RegisterParams params,
  ) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: params.email,
            password: params.password,
          );
      if (response.user == null) {
        return Left(ServerFailure(message: 'Erro ao cadastrar usuário'));
      }
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: 'Erro ao cadastrar usuário'));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserData(UserApp params) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collectionHost)
          .add(params.toJson());
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: 'Erro ao salvar dados do usuário'));
    }
  }

  @override
  Future<Either<Failure, bool>> sendEmail(String params) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: params);
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: 'Erro ao enviar email'));
    }
  }
}