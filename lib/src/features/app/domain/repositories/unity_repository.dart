import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';

abstract class UnityRepository {
  Future<Either<Failure, bool>> registerUnity(Unidade params);
}
