import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/register_params.dart';
import 'package:flexihome/src/features/app/domain/repositories/register_user_repository.dart';

class RegisterUsecase extends ParamUsecase<UserCredential, RegisterParams> {
  final RegisterRepository repository;

  RegisterUsecase({required this.repository});
  @override
  Future<Either<Failure, UserCredential>> execute(params) async {
    return await repository.registerUser(params);
  }
}