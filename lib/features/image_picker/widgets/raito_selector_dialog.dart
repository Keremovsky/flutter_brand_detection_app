import 'package:flutter/material.dart';

class RatioSelectorDialog extends StatelessWidget {
  const RatioSelectorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "En boy oranı seçin",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 1.0),
          child: Text(
            "Kare",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 2.0),
          child: Text(
            "2:1",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 0.5),
          child: Text(
            "1:2",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 4 / 3),
          child: Text(
            "4:3",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 5 / 4),
          child: Text(
            "5:4",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, -1.0),
          child: Text(
            "Geri dön",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ],
    );
  }
}
