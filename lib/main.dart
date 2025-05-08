import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flexihome/firebase_options.dart';
import 'package:flexihome/src/config/routes/app_pages.dart';
import 'package:flexihome/src/config/themes/app_theme.dart';
import 'package:flexihome/src/core/bindings/auth_binding.dart';
import 'package:flexihome/src/core/extensions/storage_helper.dart';
import 'package:flexihome/src/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting(
      'pt_BR', null); // Aguarda corretamente a formatação de datas
  await initStorage();
  await NotificationService().initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
      locale: Get.deviceLocale,
      theme: AppTheme.themeData,
      initialBinding: AuthBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
