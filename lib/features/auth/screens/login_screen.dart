import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_text_button.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Spacer(flex: 1),
              TextField(),
              const Spacer(flex: 1),
              TextField(
                obscureText: true,
              ),
              const Spacer(flex: 1),
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
              const Spacer(flex: 1),
              GestureDetector(
                onTap: () {
                  print("navigate to forgot password screen");
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
                        ..onTap = () => print("navigate to sign up screen"),
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
    );
  }
}
