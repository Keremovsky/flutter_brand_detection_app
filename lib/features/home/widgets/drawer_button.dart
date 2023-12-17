import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const CustomDrawerButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(icon, size: 35),
            const SizedBox(width: 10),
            Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
