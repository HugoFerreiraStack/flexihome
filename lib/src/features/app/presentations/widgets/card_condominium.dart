import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCondominium extends StatelessWidget {
  const CardCondominium({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(      
      color: Colors.transparent, 
      borderRadius: BorderRadius.circular(20), 
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
        InkWell(
          onTap: () {
            Get.snackbar('title', 'sub');
          },
          // todo ajustar cor no dispositivo
          splashColor: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          child:
         Container(
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
                // TODO ADC IMAGEM CONDOMINIO
                image: NetworkImage('IMAGEM CONDOMINIO.png'), 
                fit: BoxFit.cover,
              ),
              color: Colors.grey, 
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.image_not_supported,
              color: Colors.white,
              size: 30,
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
                          // todo adc o titulo da CONDOMINIO
                          'My Space',
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
        
                  Expanded(
                    child: Text(
                      // todo adc o texto importante
                      'Adicionar alguns dados que podem ser importantes para o corretor',
                      style: TextStyle(
                        color: AppColors.flexGrey,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis, 
                      maxLines: 2,
                    ),
                  ),
        
                  Text(
                    // todo adc a rua dO CONDOMINIO
                    'Rua: Genebra, 296',
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