import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_text_button.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                TextFormField(),
                const _CustomSizedBox(),
                TextFormField(
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                CustomTextButton(
                  text: Text(
                    "Giriş Yap",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  height: 40,
                  width: 120,
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
                        .copyWith(color: Palette.mainColor),
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
                            .copyWith(color: Palette.mainColor),
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
