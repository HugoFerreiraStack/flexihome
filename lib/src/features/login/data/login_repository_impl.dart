import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/features/app/domain/entities/host.dart';
import 'package:flexihome/src/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<Failure, Host>> getUserData(String params) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection(
        Constants.collectionHost,
      );

      QuerySnapshot querySnapshot =
          await users.where('id', isEqualTo: params).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        return Right(
          Host.fromJson(documentSnapshot.data() as Map<String, dynamic>),
        );
      } else {
        return Left(ServerFailure(message: 'User not found'));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
