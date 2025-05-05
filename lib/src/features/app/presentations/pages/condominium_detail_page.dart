import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/presentations/widgets/condominio_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CondominiumDetailPage extends StatelessWidget {
  const CondominiumDetailPage(
      {super.key,
      this.condominium});
  final Condominio? condominium;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: Get.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.tertiary,
          AppColors.primary,
          AppColors.secondary
        ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
          
          child: Column(children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          'Condomínio',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CondominiumForm(),
          ],
          ))
          )));
    }}