import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CardUnity extends StatelessWidget {
  const CardUnity(
      {super.key, this.title, this.text, this.image, this.agendamentos});

  final String? title;
  final String? text;
  final String? image;
  final String? agendamentos;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {},
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
                        // TODO ADC IMAGEM UNIDADE
                        image: NetworkImage('https://assets.tecnisa.com.br/content/assets/client/blog/wp-content/uploads/2021/11/Florear-Studios-na-Vila-Clementino-1024x770.jpg'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // child: Icon(
                    //   Icons.image_not_supported,
                    //   color: Colors.white,
                    //   size: 30,
                    // ),
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
                                  // todo adc o titulo da unidade
                                  title ?? '403 Genebra',
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
                              text ??
                                  'Adicionar alguns dados que podem ser importantes para o corretor',
                              style: TextStyle(
                                color: AppColors.flexGrey,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),

                          Row(
                            children: [
                              Container(
                                width: 25,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: AppColors.primary),
                                child: Text(
                                  // todo adc afazeres
                                  '3',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2),
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
