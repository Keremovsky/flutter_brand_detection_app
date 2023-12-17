import 'package:flutter/material.dart';

void giveFeedback(BuildContext context, String text, Duration duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: duration,
    ),
  );
}
