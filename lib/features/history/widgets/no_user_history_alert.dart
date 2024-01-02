import 'package:flutter/material.dart';

class NoUserHistoryAlert extends StatelessWidget {
  const NoUserHistoryAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.person_off_outlined,
          size: 80,
        ),
        const SizedBox(height: 5),
        Text(
          "Geçmişi görmek için giriş yapın.",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
