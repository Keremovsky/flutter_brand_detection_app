import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Profil",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: ThemeConstants.screenPadding,
          child: Form(
            child: Column(
              children: [
                Text(
                  "Merhaba, sayın Kerem",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 50,
                  initialValue: "Kerem",
                  decoration: InputDecoration(
                    labelText: "İsim",
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  maxLength: 20,
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    hintText: "**********",
                    hintStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: Palette.grey,
                            ),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: const EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const _CustomSizedBox(),
                CustomButton(
                  onTap: () {},
                  height: 50,
                  width: 220,
                  child: Text(
                    "Değişiklikleri Onayla",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const Spacer(),
                CustomDrawerButton(
                  icon: Icons.work_history,
                  text: "Geçmiş İsteklerim",
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  onTap: () {
                    context.pushNamed(RouterConstants.requestListScreenName);
                  },
                ),
                const _CustomSizedBox(),
                CustomDrawerButton(
                  icon: Icons.feedback,
                  text: "Geçmiş Geri Bildirimlerim",
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  onTap: () {
                    context.pushNamed(RouterConstants.feedbackListScreenName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  const _CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 12);
  }
}
