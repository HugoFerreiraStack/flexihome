import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Inicializa o banco de dados de fusos horários
    tz.initializeTimeZones();

    // Configura o fuso horário local
    final String timeZoneName = DateTime.now().timeZoneName;

    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      log('Erro ao configurar o fuso horário local: $e');
      // Define um fuso horário padrão caso o local não seja encontrado
      tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
    }

    // Configuração inicial para notificações locais
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse response) async {},
    );

    // Configuração do canal de notificação para Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'event_reminders', // ID do canal
      'Lembrete de agendamentos', // Nome do canal
      description:
          'Notificações para lembretes de eventos', // Descrição do canal
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await requestNotificationPermission();
    await requestExactAlarmPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(
        message.notification?.title ?? 'Sem título',
        message.notification?.body ?? 'Sem corpo',
      );
    });
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'event_reminders',
      'Lembrete de agendamentos',
      channelDescription: 'Notificações para lembretes de eventos',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // ID da notificação
      title,
      body,
      platformChannelSpecifics,
    );
  }

  Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      try {
        const MethodChannel platform =
            MethodChannel('flutter_local_notifications');
        final bool granted =
            await platform.invokeMethod('requestExactAlarmPermission');
        if (!granted) {
          log('Permissão para alarmes exatos não concedida.');
        }
      } catch (e) {
        log('Erro ao solicitar permissão para alarmes exatos: $e');
      }
    }
  }

  Future<void> scheduleNotification(
      String title, String body, DateTime scheduledDate) async {
    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local), // Data agendada
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'event_reminders',
            'Lembrete de agendamentos',
            channelDescription: 'Notificações para lembretes de eventos',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
      );
    } catch (e) {
      log('Erro ao agendar notificação: $e');
    }
  }
}

Future<void> requestNotificationPermission() async {
  // Solicita permissão para notificações (Firebase Messaging)
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    log('Permissão concedida para notificações.');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    log('Permissão provisória concedida para notificações.');
  } else {
    log('Permissão negada para notificações.');
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Mensagem recebida em segundo plano: ${message.messageId}');
}
