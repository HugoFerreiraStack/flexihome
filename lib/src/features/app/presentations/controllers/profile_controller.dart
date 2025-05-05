import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final _buttons = <Widget>[].obs;
  List<Widget> get buttons => _buttons;
  set buttons(value) => _buttons.value = value;

  void generateButtons() {
    buttons.clear();
    buttons.addAll([
      ElevatedButton(
        onPressed: () {
          AuthService.to.signOut();
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
          textStyle: TextStyle(fontSize: 18),
        ),
        child:  Text('Logout'),
      ),
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    generateButtons();
  }
}
