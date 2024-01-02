import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  late final TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                controller: textController,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: const InputDecoration(
                  labelText: "E-mail",
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                onTap: () {
                  if (textController.text.isNotEmpty) {
                    // control if it is a valid email
                    if (emailValidator(textController.text)) {
                      giveFeedback(context, "Geçersiz email formatı.");
                      return;
                    }
                    // send reset password request
                    context.pushNamed(RouterConstants.resetPasswordScreenName);
                  } else {
                    giveFeedback(context, "Lütfen email alanını doldurun.");
                  }
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
