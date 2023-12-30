import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kayıt Ol",
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
                TextFormField(
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "İsim",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  obscureText: true,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Şifre",
                  ),
                ),
                const _CustomSizedBox(),
                TextFormField(
                  obscureText: true,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Tekrar şifre",
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onTap: () {},
                  height: 50,
                  width: 120,
                  child: Text(
                    "Kayıt Ol",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
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
    return const SizedBox(height: 15);
  }
}
