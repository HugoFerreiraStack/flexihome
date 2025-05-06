import 'package:flexihome/src/features/app/presentations/bindings/app_binding.dart';
import 'package:flexihome/src/features/app/presentations/bindings/condominium_binding.dart';
import 'package:flexihome/src/features/app/presentations/bindings/unity_binding.dart';
import 'package:flexihome/src/features/app/presentations/pages/app_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/condominiuns_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/details_condominium_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/details_unity_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/register_condominium_page.dart';
import 'package:flexihome/src/features/login/presentations/bindings/login_binding.dart';
import 'package:flexihome/src/features/login/presentations/pages/login_page.dart';
import 'package:flexihome/src/features/splash/presentations/bindings/splash_binding.dart';
import 'package:flexihome/src/features/splash/presentations/pages/splash_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.APP,
      page: () => AppPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: AppRoutes.CONDOMINIUM_DETAILS,
      page: () => DetailsCondominiumPage(),
      binding: CondominiumBinding()),
    GetPage(
      name: AppRoutes.REGISTER_CONDOMINIUM,
      page: () => RegisterCondominiumPage()),
    GetPage(
      name: AppRoutes.DETAILS_UNITY,
      page: ()=> DetailsUnity(),
      binding: UnityBinding())
  ];
}
