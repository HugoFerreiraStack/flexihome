import 'package:flexihome/src/features/app/data/cep_repository_impl.dart';
import 'package:flexihome/src/features/app/data/condominium_repository_impl.dart';
import 'package:flexihome/src/features/app/data/unity_repository_impl.dart';
import 'package:flexihome/src/features/app/domain/usecases/cep_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/register_condominium_usecase.dart';
import 'package:flexihome/src/features/app/domain/usecases/set_unity_usecase.dart';
import 'package:flexihome/src/features/app/presentations/controllers/app_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/profile_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    final CepUsecase cepUsecase = CepUsecase(repository: CepRepositoryImpl());
    final SetunityUsecase setunityUsecase = SetunityUsecase(
      repository: UnityRepositoryImpl(),
    );
    final SetCondominioUsecase setCondominioUsecase = SetCondominioUsecase(
      repository: CondominiumRepositoryImpl(),
    );

    Get.put<AppController>(AppController());

    Get.put<RegisterCondominiumController>(
      RegisterCondominiumController(
        cepUsecase: cepUsecase,
        setCondominioUsecase: setCondominioUsecase,
      ),
    );

    Get.put(
      RegisterUnityController(
        cepUsecase: cepUsecase,
        setunityUsecase: setunityUsecase,
      ),
    );

    Get.put<ProfileController>(ProfileController());
  }
}
