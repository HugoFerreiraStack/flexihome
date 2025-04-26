// widgets/error_dialog.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorDialog(String message) {
  Get.dialog(
    AlertDialog(
      title: Text('Erro'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('OK'),
        ),
      ],
    ),
    barrierDismissible: false,
  );
}
