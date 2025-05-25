import 'package:dartz/dartz.dart';
import 'package:flexihome/src/core/errors/failure.dart';
import 'package:flexihome/src/core/usecases/base_usecase.dart';
import 'package:flexihome/src/features/app/domain/repositories/register_user_repository.dart';

class SendEmailUsecase extends ParamUsecase<bool, String> {
  final RegisterRepository repository;

  SendEmailUsecase({required this.repository});
  @override
  Future<Either<Failure, bool>> execute(params) async {
    return await repository.sendEmail(params);
  }
}