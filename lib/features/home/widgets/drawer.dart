import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends ConsumerWidget {
  final Function() refresh;

  const CustomDrawer({super.key, required this.refresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        CustomDrawerButton(
          icon: Icons.account_circle_rounded,
          text: "Hesabım",
          onTap: () => context.pushNamed(RouterConstants.loginScreenName),
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.settings,
          text: "Ayarlar",
          onTap: () async {
            await context.pushNamed(RouterConstants.settingsScreenName);
            refresh();
          },
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.send_rounded,
          text: "İstekte Bulun",
          onTap: () {
            final userModel = ref.read(userModelProvider).value;
            if (userModel == null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        "İstek",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Text(
                      "İstekte bulunabilmek için giriş yapmanız gerekmekmektedir.",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  );
                },
              );
            } else {
              context.pushNamed(RouterConstants.sendRequestScreenName);
            }
          },
        ),
        const _CustomSizedBox(),
        CustomDrawerButton(
          icon: Icons.save_outlined,
          text: "Kaydedilenler",
          onTap: () {},
        ),
        const _CustomSizedBox(),
        // sign in and sign out button
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
