import 'package:dartz/dartz.dart';

import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/login/domain/repositories/login_repository.dart';

class LoginUsecase extends ParamUsecase<UserApp, String> {
  final LoginRepository repository;

  LoginUsecase({required this.repository});
  @override
  Future<Either<Failure, UserApp>> execute(params) async {
    return repository.getUserData(params);
  }
}
