import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/presentations/controllers/add_schedule_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_condominium_controller.dart';
import 'package:flexihome/src/features/app/presentations/controllers/register_unity_controller.dart';
import 'package:flexihome/src/features/app/presentations/pages/calendar_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/condominiuns_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/profile_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/unities_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final _currentIndex = 0.obs;
  set currentIndex(value) => _currentIndex.value = value;
  get currentIndex => _currentIndex.value;

  List<Widget> pages = [
    CalendarPage(),
    CondominiunsPage(),
    UnitiesPage(),
    ProfilePage()
  ];

  void getEvents() {
    AddScheduleController.to
        .getEventsByImobiliaria(AuthService.to.host!.idImobiliaria!);
    AddScheduleController.to.getCondominiums();
  }

  void getCondominiums() {
    RegisterCondominiumController.to.getCondominiums();
  }

  void getUnities() {
    RegisterUnityController.to.getUnitys();
  }

  void onTapAppBar(int index) {
    currentIndex = index;
    switch (index) {
      case 0:
        getEvents();
        break;
      case 1:
        getCondominiums();
        break;
      case 2:
        getUnities();
      default:
    }
  }

  List<BottomNavigationBarItem> bottomNavitems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month), label: 'Calendário'),
    BottomNavigationBarItem(
        icon: Icon(Icons.apartment_rounded), label: 'Condomínios'),
    BottomNavigationBarItem(
        icon: Icon(Icons.home_work_sharp), label: 'Unidades'),
    // BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Corretores'),
    BottomNavigationBarItem(
        icon: Icon(Icons.contacts_rounded), label: 'Perfil'),
  ];
}
