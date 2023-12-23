import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Color backgroundColor;
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget child;

  const CustomButton({
    super.key,
    required this.onTap,
    this.backgroundColor = Palette.mainColor,
    required this.height,
    required this.width,
    this.borderRadius,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Builder(builder: (context) {
          ThemeData currentTheme = Theme.of(context);
          if (backgroundColor == Palette.mainColor &&
              !isThemeLight(currentTheme)) {
            return Ink(
              decoration: BoxDecoration(
                color: isThemeLight(currentTheme)
                    ? backgroundColor
                    : Palette.darkMainColor,
                borderRadius: borderRadius,
              ),
              child: SizedBox(
                height: height,
                width: width,
                child: Center(child: child),
              ),
            );
          }

          return Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
            ),
            child: SizedBox(
              height: height,
              width: width,
              child: Center(child: child),
            ),
          );
        }),
      ),
    );
  }
}
