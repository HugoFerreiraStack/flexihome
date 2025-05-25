import 'package:flexihome/src/features/app/presentations/bindings/add_schedule_binding.dart';
import 'package:flexihome/src/features/app/presentations/bindings/app_binding.dart';
import 'package:flexihome/src/features/app/presentations/bindings/calendar_binding.dart';
import 'package:flexihome/src/features/app/presentations/bindings/unity_binding.dart';
import 'package:flexihome/src/features/app/presentations/pages/add_schedule_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/app_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/calendar_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/condominium_detail_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/details_unity_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/register_user_page.dart';
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
        bindings: [AppBinding(), CalendarBinding()]),
    GetPage(
        name: AppRoutes.CONDOMINIUMDETAILS,
        page: () => CondominiumDetailPage()),
    GetPage(
        name: AppRoutes.DETAILS_UNITY,
        page: () => DetailsUnity(),
        binding: UnityBinding()),
    GetPage(
        name: AppRoutes.REGISTER_USER,
        page: () => RegisterPage(),
        binding: AppBinding()),
    GetPage(
        name: AppRoutes.ADD_SCHEDULE,
        page: () => AddSchedulePage(),
        binding: AddScheduleBinding()),
    GetPage(
        name: AppRoutes.CALENDAR,
        page: () => CalendarPage(),
        binding: CalendarBinding()),
  ];
}
