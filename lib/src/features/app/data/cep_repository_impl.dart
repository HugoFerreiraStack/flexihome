import 'dart:math';

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
      var endereco = InfoCep();
      response.fold(
        (error) {
          return Left(ServerFailure(message: error.errorMessage));
        },
        (info) {
          endereco.cep = info.cep;
          endereco.logradouro = info.logradouro;
          endereco.bairro = info.bairro;
          endereco.localidade = info.localidade;
          endereco.uf = info.uf;
          return Right(info);
        },
      );

      return Right(endereco);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
