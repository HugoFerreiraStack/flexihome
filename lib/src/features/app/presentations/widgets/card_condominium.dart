import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/presentations/pages/condominium_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCondominium extends StatelessWidget {
  const CardCondominium(
      {super.key,
      this.condominium});
  final Condominio? condominium;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: InkWell(
            onTap: () {
              Get.to(() => CondominiumDetailPage(condominium: condominium));
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
                        image: AssetImage(AppAssets.condominios),
                        fit: BoxFit.contain,
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
                        children: [
                          // Título
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  condominium?.nome ?? 'My Space',
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
                          SizedBox(height: 8),
                          Text(
                                'Apartamentos registrados: ${condominium?.totalUnitys ?? 0}',
                            style: TextStyle(
                              color: AppColors.flexGrey,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${condominium?.logradouro} / ${condominium?.numero} / ${condominium?.bairro}",
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
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
