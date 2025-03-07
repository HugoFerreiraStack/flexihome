import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/endereco.dart';
import 'package:flexihome/src/features/app/domain/entities/info_cep.dart';
import 'package:flexihome/src/features/app/domain/repositories/cep_repository.dart';
import 'package:search_cep/search_cep.dart';

class CepRepositoryImpl implements CepRepository {
  @override
  Future<Either<Failure, InfoCep>> searchCep(String params) async {
    try {
      final viaCepSearchCep = ViaCepSearchCep();
      final response = await viaCepSearchCep.searchInfoByCep(cep: params);
      response.fold(
        (error) {
          return Left(ServerFailure(message: error.errorMessage));
        },
        (info) {
          final addressInfo = Endereco(
            cep: info.cep,
            logradouro: info.logradouro,
            bairro: info.bairro,
            cidade: info.localidade,
            estado: info.uf,
          );
          return Right(addressInfo);
        },
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
    return Left(ServerFailure(message: 'Unexpected error'));
  }
}
