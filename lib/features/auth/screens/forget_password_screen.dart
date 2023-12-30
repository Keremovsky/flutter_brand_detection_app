import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Şifre Yenileme",
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
          child: Column(
            children: [
              TextField(
                style: Theme.of(context).textTheme.labelSmall,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onTap: () {
                  context.pushNamed(RouterConstants.resetPasswordScreenName);
                },
                height: 50,
                width: 150,
                child: Text(
                  "E-posta yolla",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
