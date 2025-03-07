import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/set_condominium_params.dart';
import 'package:flexihome/src/features/app/domain/repositories/condominium_repository.dart';

class SetCondominioUsecase extends ParamUsecase<bool, SetCondominiumParams> {
  final CondominiumRepository repository;

  SetCondominioUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(SetCondominiumParams params) async {
    return await repository.registerCondominium(params);
  }
}
