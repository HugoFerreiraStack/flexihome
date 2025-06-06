import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/login/presentations/controllers/login_controller.dart';
import 'package:flexihome/src/features/login/presentations/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.tertiary,
                AppColors.primary,
                AppColors.secondary
              ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
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
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LoginForm(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: SizedBox(
                      width: getValueForScreenType(
                          context: context,
                          mobile: 80.sw,
                          tablet: 70.sw,
                          desktop: 70.sw),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(
                                () => Checkbox(
                                  checkColor: AppColors.primary,
                                  fillColor:
                                      WidgetStateProperty.all(Colors.white),
                                  value: controller.rememberMe,
                                  onChanged: (bool? value) {
                                    controller.rememberMe = value!;
                                  },
                                ),
                              ),
                              Text(
                                'Manter logado',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.resetPassword();
                            },
                            child: Text(
                              'Esqueci a senha',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text('Acessar'),
                  ),
                  // TODO COMENTADO ENQUANTO NÃO TEM O ACESSO PARA CRIAR UM NOVO USUÁRIO
                  // const SizedBox(height: 50),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child: RichText(
                  //     text: const TextSpan(
                  //       text: 'Não possui uma conta? ', style: TextStyle(color: Colors.white),
                  //       children: [
                  //         TextSpan(
                  //           text: 'Clique aqui',
                  //           style: TextStyle(
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.white
                  //           ),
                  //         ),
                  //         TextSpan(
                  //             text:
                  //                 ' e entre em contato para saber mais sobre a maior rede de gerenciamento de casas e apartamentos ágeis.', style: TextStyle(color: Colors.white)),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
