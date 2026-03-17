import 'package:flutter/material.dart';

void snackBar({
  required String text,
  required BuildContext context,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
      backgroundColor: color,
    ),
  );
}
