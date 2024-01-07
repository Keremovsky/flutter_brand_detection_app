import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name;
  String? password;
  String? validatePass;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider)!;
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
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Merhaba, sayın ${user.name}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLength: 50,
                  initialValue: user.name,
                  onSaved: (value) {
                    name = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "İsim",
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
                const _CustomSizedBox(),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      // update username
                      if (name! != user.name) {
                        await ref
                            .read(authControllerProvider.notifier)
                            .changeName(
                              context,
                              user.id,
                              name!,
                            );
                      }
                    }
                  },
                  height: 50,
                  width: 220,
                  child: Text(
                    "Değişiklikleri Onayla",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  onTap: () async {
                    await ref
                        .read(authControllerProvider.notifier)
                        .resetPasswordRequest(
                          context,
                          user.email,
                        );
                  },
                  height: 50,
                  width: 150,
                  child: Text(
                    "Şifre Yenile",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const _CustomSizedBox(),
                CustomDrawerButton(
                  icon: Icons.work_history,
                  text: "Geçmiş İsteklerim",
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  onTap: () {
                    context.pushNamed(
                      RouterConstants.requestListScreenName,
                      extra: user.id,
                    );
                  },
                ),
                const _CustomSizedBox(),
                CustomDrawerButton(
                  icon: Icons.feedback,
                  text: "Geçmiş Geri Bildirimlerim",
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  onTap: () {
                    context.pushNamed(
                      RouterConstants.feedbackListScreenName,
                      extra: user.id,
                    );
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
