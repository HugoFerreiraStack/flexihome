
import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/app/domain/repositories/register_user_repository.dart';

class SaveUserUsecase extends ParamUsecase<bool, UserApp> {
  final RegisterRepository repository;

  SaveUserUsecase({required this.repository});
  @override
  Future<Either<Failure, bool>> execute(UserApp params)async {
 return await repository.saveUserData(params);
  }
}