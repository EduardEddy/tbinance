import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final IconData? iconLeft;
  final IconButton? iconRight;
  final String? Function(String?) validate;
  final int maxLines;
  final bool isObscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  const CustomInput({
    super.key,
    required this.hintText,
    this.iconLeft,
    required this.validate,
    this.iconRight,
    this.maxLines = 1,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      obscureText: isObscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: iconLeft == null ? null : Icon(iconLeft),
        suffixIcon: iconRight,
      ),
      maxLines: maxLines,
    );
  }
}
