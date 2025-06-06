import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/repositories/condominium_repository.dart';

class CondominiumRepositoryImpl implements CondominiumRepository {
  @override
  Future<Either<Failure, bool>> registerCondominium(
    Condominio params,
  ) async {
    log('Registering condominium: ${params.toJson()}');
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collectionCondominio)
          .doc(params.id)
          .set(params.toJson());
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
