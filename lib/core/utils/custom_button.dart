import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final double? elevation;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget child;

  const CustomButton({
    super.key,
    required this.onTap,
    this.backgroundColor,
    this.height,
    this.width,
    this.elevation,
    this.borderRadius,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(),
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          color: backgroundColor,
          elevation: elevation ?? 1,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
