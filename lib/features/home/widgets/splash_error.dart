import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/assets_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';

class SplashError extends StatelessWidget {
  final Function() refresh;

  const SplashError({super.key, required this.refresh});

  @override
  Widget build(BuildContext context) {
    final isThemeLight = isThemeLightFunc(context);
    return Column(
      children: [
        const Spacer(flex: 1),
        ImageDemonstrator(
          imageProvider: isThemeLight
              ? const AssetImage(AssetsConstants.noConnectionBlack)
              : const AssetImage(AssetsConstants.noConnectionWhite),
          borderRadius: BorderRadius.circular(10),
          outerPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        Text(
          "Sunucu ile bağlantı kurulamadı!",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 15),
        CustomButton(
          onTap: refresh,
          height: 70,
          width: 70,
          borderRadius: BorderRadius.circular(1000),
          child: const Icon(
            Icons.refresh,
            size: 45,
          ),
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}
