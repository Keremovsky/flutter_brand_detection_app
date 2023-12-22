import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class SingleResultScreen extends StatelessWidget {
  const SingleResultScreen({super.key});

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
          child: Column(
            children: [
              Text(
                "Sonuç",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              ImageDemonstrator(
                imageProvider: const AssetImage("assets/ferrari.png"),
                height: 200,
                width: 200,
                borderRadius: BorderRadius.circular(10),
              ),
              Text(
                "Ferrari",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const CustomSizedBox(),
              Text(
                "Official account of #Ferrari, Italian Excellence that makes the world dream.",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const CustomSizedBox(),
              Text(
                "Maranello | Italy",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      launchURL("https://twitter.com/home?lang=en");
                    },
                    height: 40,
                    width: 80,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Palette.xColor,
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/x_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  const CustomSizedBox(),
                  CustomButton(
                    onTap: () {
                      launchURL("https://www.google.com");
                    },
                    height: 40,
                    width: 80,
                    borderRadius: BorderRadius.circular(10),
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/google_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSizedBox extends StatelessWidget {
  const CustomSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
