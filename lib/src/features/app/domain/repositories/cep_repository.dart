import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/info_cep.dart';

abstract class CepRepository {
  Future<Either<Failure, InfoCep>> searchCep(String params);
}
