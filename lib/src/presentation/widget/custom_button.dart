import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() action;
  final Color? bgColor;
  final Color? textColor;
  const CustomButton({
    super.key,
    required this.label,
    required this.icon,
    required this.action,
    this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: action,
      icon: Icon(
        icon,
        color: textColor,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
