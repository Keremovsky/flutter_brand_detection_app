import 'package:flutter/material.dart';

class ImageDemonstrator extends StatelessWidget {
  final ImageProvider imageProvider;
  final double? height;
  final double? width;
  final BorderRadius borderRadius;

  const ImageDemonstrator({
    super.key,
    required this.imageProvider,
    this.height,
    this.width,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: width,
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
