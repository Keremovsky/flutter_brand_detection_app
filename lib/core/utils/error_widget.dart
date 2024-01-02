import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class ErrorAlertWidget extends StatelessWidget {
  const ErrorAlertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.error_outline,
          color: Palette.red,
          size: 80,
        ),
        const SizedBox(height: 5),
        Text(
          "Bir hata meydana geldi.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
