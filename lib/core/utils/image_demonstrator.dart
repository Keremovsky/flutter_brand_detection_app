import 'package:flutter/material.dart';

class ImageDemonstrator extends StatelessWidget {
  final ImageProvider imageProvider;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry outerPadding;
  final BorderRadius borderRadius;

  const ImageDemonstrator({
    super.key,
    required this.imageProvider,
    this.height,
    this.width,
    this.outerPadding = const EdgeInsets.only(),
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          height: height,
          width: width,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
