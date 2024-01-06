import 'package:flutter/material.dart';

class NoHistoryAlert extends StatelessWidget {
  const NoHistoryAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.no_backpack_outlined,
          size: 80,
        ),
        const SizedBox(height: 5),
        Text(
          "Kayıtlı bir aramanız bulunmamakta.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
