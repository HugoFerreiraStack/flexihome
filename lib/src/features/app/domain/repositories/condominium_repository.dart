import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';

abstract class CondominiumRepository {

  Future<Either<Failure, bool>> registerCondominium(Condominio params);
}