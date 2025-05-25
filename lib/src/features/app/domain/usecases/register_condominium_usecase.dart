import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/repositories/condominium_repository.dart';

class SetCondominioUsecase extends ParamUsecase<bool, Condominio> {
  final CondominiumRepository repository;

  SetCondominioUsecase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(Condominio params) async {
    return await repository.registerCondominium(params);
  }
}
