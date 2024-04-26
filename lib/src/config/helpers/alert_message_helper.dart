import 'package:flutter/material.dart';

alertMessage(context, text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
