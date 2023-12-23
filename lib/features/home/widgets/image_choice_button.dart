import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class ImageChoiceButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final double height;
  final double width;
  final Function() onTap;

  const ImageChoiceButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.height,
    required this.width,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ThemeData currentTheme = Theme.of(context);

        return Material(
          color: isThemeLight(currentTheme)
              ? Palette.mainColor
              : Palette.darkMainColor,
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: height,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(image: AssetImage(imagePath)),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
