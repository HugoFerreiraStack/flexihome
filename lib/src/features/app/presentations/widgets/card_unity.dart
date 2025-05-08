import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardUnity extends StatelessWidget {
  const CardUnity({super.key, required this.unity});
  final Unidade unity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.DETAILS_UNITY, arguments: unity);
            },
            // todo ajustar cor no dispositivo
            splashColor: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.unidade),
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Título
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // todo adc o titulo da unidade
                                  // "${unity.endereco?.logradouro} -  ${unity.numberAp!}",
                                  "${unity.name}",
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ],
                          ),
                          // EVENTOS
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: AppColors.primary),
                                child: Text(
                                  // todo adc afazeres
                                   unity.eventos?.length.toString() ??'0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Eventos próximos',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Text(
                                '${unity.endereco?.logradouro}, ${unity.endereco?.bairro}',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                          // TODO DESENVOLVER FUNCIONALIDADE DE MAPA
                          // MapsButton(address: "${unity.endereco?.logradouro}, ${unity.endereco?.cidade}")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
