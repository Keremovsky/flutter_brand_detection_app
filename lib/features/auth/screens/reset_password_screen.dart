import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? validateCode;
  String? password;
  String? validatePass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Doğrulama",
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
                    validateCode = value;
                  },
                  validator: (value) => validate(value),
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Doğrulama kodu",
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (passwordValidator(value)) {
                        return "Lütfen şifreyi uygun formatta girin.";
                      }
                    }

                    return validate(value);
                  },
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Yeni şifre",
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  obscureText: true,
                  onSaved: (value) {
                    validatePass = value;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (passwordValidator(value)) {
                        return "Lütfen şifreyi uygun formatta girin.";
                      }
                    }

                    return validate(value);
                  },
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    labelText: "Yeni şifre tekrar",
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      if (password != validatePass) {
                        giveFeedback(context, "Şifreler eşleşmiyor.");
                        return;
                      }
                    }
                    // reset password
                  },
                  height: 50,
                  width: 140,
                  child: Text(
                    "Şifreyi yenile",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
