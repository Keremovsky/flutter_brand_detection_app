import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const CustomCircularProgressIndicator({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
