import 'package:flexihome/src/features/app/presentations/pages/calendar_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/condominiuns_page.dart';
import 'package:flexihome/src/features/app/presentations/pages/unities_page.dart';
import 'package:flexihome/src/features/app/presentations/widgets/card_unity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final _currentIndex = 0.obs;
  set currentIndex(value) => _currentIndex.value = value;
  get currentIndex => _currentIndex.value;

  List<Widget> pages = [
    CalendarPage(),
    // Container(color: Colors.pink, child: Column(children: [Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 32),
    //   child: CardUnity(),
    // )],)),
    // Container(color: Colors.cyan, child: Column(children: [Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 32),
    //   child: CardUnity(),
    // )],)),
    CondominiunsPage(),
    UnitiesPage(),
  ];

  List<BottomNavigationBarItem> bottomNavitems = [
    BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendário'),
    BottomNavigationBarItem(icon: Icon(Icons.apartment_rounded), label: 'Condomínios'),
    BottomNavigationBarItem(icon: Icon(Icons.home_work_sharp), label: 'Unidades'),
    // BottomNavigationBarItem(icon: Icon(Icons.people_alt_rounded), label: 'Corretores'),
    // BottomNavigationBarItem(icon: Icon(Icons.contacts_rounded), label: 'Perfil'),
  ];
}
