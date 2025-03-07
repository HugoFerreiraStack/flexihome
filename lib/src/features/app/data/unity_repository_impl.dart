import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flexihome/src/features/app/domain/repositories/unity_repository.dart';

class UnityRepositoryImpl implements UnityRepository {
  @override
  Future<Either<Failure, bool>> registerUnity(Unidade params) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.collectionUnidade)
          .add(params.toJson());
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
