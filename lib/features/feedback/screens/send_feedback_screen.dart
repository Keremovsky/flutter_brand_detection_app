import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SendFeedbackScreen extends ConsumerStatefulWidget {
  const SendFeedbackScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendFeedbackScreenState();
}

class _SendFeedbackScreenState extends ConsumerState<SendFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              Text(
                "Geri Bildirim Yolla",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 7,
                maxLength: 250,
                style: Theme.of(context).textTheme.labelSmall,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: "Açıklama",
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      context.pop();
                    },
                    height: 50,
                    width: 100,
                    backgroundColor: Palette.red,
                    child: Text(
                      "İptal",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  CustomButton(
                    onTap: () {},
                    height: 50,
                    width: 100,
                    child: Text(
                      "Yolla",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
