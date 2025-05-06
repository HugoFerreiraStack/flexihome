import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, tertiary, custom }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final Color? customButtonBackgroundColor;
  final Color? customButtonTextColor;
  final String textButton;
  final VoidCallback function;

  const CustomButton({
    Key? key,
    required this.buttonType,
    required this.textButton,
    required this.function,
    this.customButtonBackgroundColor,
    this.customButtonTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lógica para definir cores
    Color backgroundColor;
    Color textColor;

    switch (buttonType) {
      case ButtonType.primary:
        backgroundColor = AppColors.primary;
        textColor = Colors.white;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors.secondary;
        textColor = Colors.white;
        break;
      case ButtonType.tertiary:
        backgroundColor = Colors.white;
        textColor = AppColors.tertiary;
        break;
      case ButtonType.custom:
        backgroundColor = customButtonBackgroundColor ?? Colors.grey;
        textColor = customButtonTextColor ?? Colors.white;
        break;
    }

    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(
          textButton,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
