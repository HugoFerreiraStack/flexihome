import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/features/login/presentations/controllers/login_controller.dart';
import 'package:flexihome/src/features/login/presentations/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Image.asset(AppAssets.appLogo, width: 120),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'FLEXIHOME',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontFamily: 'Julius Sans One',
                    letterSpacing: 0.5,
                  ),
                ),
              ),SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
