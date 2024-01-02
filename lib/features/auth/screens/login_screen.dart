import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/assets_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Giriş Yap",
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
                TextFormField(
                  onSaved: (value) {
                    email = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  obscureText: true,
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Şifre",
                  ),
                ),
                const SizedBox(height: 40),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      // save values
                      formKey.currentState!.save();
                      // send request to login
                      ref.read(authControllerProvider.notifier).login(
                            context,
                            email!,
                            password!,
                          );
                    }
                  },
                  height: 50,
                  width: 120,
                  child: Text(
                    "Giriş Yap",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                const _CustomSizedBox(),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(RouterConstants.forgetPasswordScreenName);
                  },
                  child: Text(
                    "Şifremi unuttum.",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Palette.blue),
                  ),
                ),
                const Spacer(flex: 3),
                CustomButton(
                  onTap: () {},
                  height: 60,
                  width: 60,
                  child: const ImageDemonstrator(
                    imageProvider: AssetImage(AssetsConstants.googleLogo),
                    outerPadding: EdgeInsets.all(10),
                  ),
                ),
                const Spacer(flex: 12),
                RichText(
                  text: TextSpan(
                    text: "Hesabınız yok mu? ",
                    style: Theme.of(context).textTheme.displaySmall,
                    children: [
                      TextSpan(
                        text: "Hesap oluştur",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context
                                .pushNamed(RouterConstants.registerScreenName);
                          },
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: Palette.blue),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 4),
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
    return const SizedBox(height: 15);
  }
}
