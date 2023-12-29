import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class ModelListItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  final String? content;
  final ImageProvider image;
  final Widget? subChild;
  final dynamic model;

  const ModelListItem({
    super.key,
    required this.title,
    required this.onTap,
    this.content,
    required this.image,
    this.subChild,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 110,
          child: Card(
            child: Row(
              children: [
                ImageDemonstrator(
                  imageProvider: image,
                  height: 100,
                  width: 100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 130,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 5,
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.displayLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 30,
                        child: Text(
                          content ?? "",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: subChild ?? const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
