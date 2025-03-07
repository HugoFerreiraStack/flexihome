import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/set_condominium_params.dart';

abstract class CondominiumRepository {

  Future<Either<Failure, bool>> registerCondominium(SetCondominiumParams params);
}