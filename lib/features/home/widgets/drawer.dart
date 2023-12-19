import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDrawerButton(
          icon: Icons.account_circle_rounded,
          text: "Hesabım",
          onTap: () {
            context.pushNamed(RouterConstants.loginScreenName);
          },
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.settings,
          text: "Ayarlar",
          onTap: () {},
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.send_rounded,
          text: "İstekte Bulun",
          onTap: () {},
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.logout_outlined,
          text: "Çıkış Yap",
          onTap: () {},
        ),
        // const HistoryComponent(size: 160, isSavedOnes: true),
      ],
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  const _CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 8);
  }
}
