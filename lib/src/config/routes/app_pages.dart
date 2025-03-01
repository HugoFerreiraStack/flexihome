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
    GetPage(name: AppRoutes.LOGIN, page: () => LoginPage()),
  ];
}
