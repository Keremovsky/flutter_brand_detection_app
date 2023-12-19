import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_text_button.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            child: Column(
              children: [
                TextFormField(),
                const _CustomSizedBox(),
                TextFormField(),
                const _CustomSizedBox(),
                TextFormField(
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                CustomTextButton(
                  text: Text(
                    "Kayıt Ol",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  height: 40,
                  width: 120,
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
