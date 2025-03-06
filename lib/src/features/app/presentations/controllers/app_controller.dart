import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final _currentIndex = 0.obs;
  set currentIndex(value) => _currentIndex.value = value;
  get currentIndex => _currentIndex.value;

  List<Widget> pages = [
    Container(color: Colors.blue),
    Container(color: Colors.blue),
    Container(color: Colors.blue),
  ];

  List<BottomNavigationBarItem> bottomNavitems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.add_business),
      label: 'Unidades',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.add_business), label: 'Condomínios'),
  ];
}
