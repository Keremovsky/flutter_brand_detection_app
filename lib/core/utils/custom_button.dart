import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function() onTap;
  final Color backgroundColor;
  final double height;
  final double width;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
    this.backgroundColor = Palette.mainColor,
    required this.height,
    required this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: Center(child: child),
        ),
      ),
    );
  }
}
