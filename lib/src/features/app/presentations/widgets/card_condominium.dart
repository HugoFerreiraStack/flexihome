import 'package:flexihome/src/config/themes/app_assets.dart';
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardCondominium extends StatelessWidget {
  const CardCondominium(
      {super.key,
      this.title,
      this.description,
      this.address,
      this.totalUnitys = 0});
  final String? title;
  final String? description;
  final String? address;
  final int? totalUnitys;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: InkWell(
            onTap: () {
              //    Get.snackbar('title', 'sub');
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
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
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
                                  title ?? 'My Space',
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
                            description ??
                                'Apartamentos registrados: $totalUnitys',
                            style: TextStyle(
                              color: AppColors.flexGrey,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 8),
                          Text(
                            address ?? '',
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
