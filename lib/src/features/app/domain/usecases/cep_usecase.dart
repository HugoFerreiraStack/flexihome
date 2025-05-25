import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/entities/info_cep.dart';
import 'package:flexihome/src/features/app/domain/repositories/cep_repository.dart';

class CepUsecase extends ParamUsecase<InfoCep, String> {
  final CepRepository repository;

  CepUsecase({required this.repository});

  @override
  Future<Either<Failure, InfoCep>> execute(String params) async {
    return await repository.searchCep(params);
  }
}
