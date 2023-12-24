import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
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
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              Text(
                "Geri Bildirim Yolla",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextField(
                maxLines: 5,
                maxLength: 500,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {},
                    height: 40,
                    width: 100,
                    backgroundColor: Palette.red,
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "İptal",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  CustomButton(
                    onTap: () {},
                    height: 40,
                    width: 100,
                    borderRadius: BorderRadius.circular(10),
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
