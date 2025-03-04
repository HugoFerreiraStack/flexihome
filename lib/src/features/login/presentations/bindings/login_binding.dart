import 'package:flexihome/src/features/login/data/login_repository_impl.dart';
import 'package:flexihome/src/features/login/domain/usecases/login_usecase.dart';
import 'package:flexihome/src/features/login/presentations/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    final LoginUsecase loginUsecase = LoginUsecase(
      repository: LoginRepositoryImpl(),
    );
    Get.put<LoginController>(LoginController(loginUsecase: loginUsecase));
  }
}
