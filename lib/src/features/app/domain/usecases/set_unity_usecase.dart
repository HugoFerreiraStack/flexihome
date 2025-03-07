import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flexihome/src/features/app/domain/repositories/unity_repository.dart';

class SetunityUsecase extends ParamUsecase<bool, Unidade> {
  final UnityRepository repository;

  SetunityUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(Unidade params) async {
    return await repository.registerUnity(params);
  }
}
