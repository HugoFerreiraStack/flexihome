import 'package:firebase_core/firebase_core.dart';
import 'package:flexihome/firebase_options.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/config/themes/app_theme.dart';
import 'package:flexihome/src/core/bindings/auth_binding.dart';
import 'package:flexihome/src/core/extensions/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting(
      'pt_BR', null); // Aguarda corretamente a formatação de datas
  await initStorage();
  runApp(const MyApp()); // Só roda após a formatação estar pronta
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppRoutes.SPLASH,
      theme: AppTheme.themeData,
      initialBinding: AuthBinding(),
    );
  }
}
