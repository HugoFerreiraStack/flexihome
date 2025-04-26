// widgets/end_date_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<bool> showEndDateDialog(String title, String repeat, DateTime date) async {
  return await Get.dialog<bool>(
    AlertDialog(
      title: Text(title),
      content: Text(
        'Este evento vai repetir "$repeat" até: ${DateFormat('dd/MM/yyyy').format(date)}. Confirmar?',
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text('Confirmar'),
        ),
      ],
    ),
    barrierDismissible: false,
  ) ?? false;
}
