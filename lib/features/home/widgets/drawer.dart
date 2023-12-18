import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_component.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDrawerButton(
          icon: Icons.account_circle_rounded,
          text: "Hesabım",
          onTap: () {},
        ),
        CustomDrawerButton(
          icon: Icons.settings,
          text: "Ayarlar",
          onTap: () {},
        ),
        CustomDrawerButton(
          icon: Icons.send_rounded,
          text: "İstekte Bulun",
          onTap: () {},
        ),
        const HistoryComponent(size: 160, isSavedOnes: false),
      ],
    );
  }
}
