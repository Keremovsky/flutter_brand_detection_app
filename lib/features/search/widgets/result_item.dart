import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class ResultItem extends StatelessWidget {
  const ResultItem({super.key});

  _calculateColor(int per) {
    if (per >= 50) {
      return ColorTween(
        begin: Palette.yellow,
        end: Palette.green,
      ).lerp((per - 50) / 50);
    } else {
      return ColorTween(
        begin: Palette.red,
        end: Palette.yellow,
      ).lerp((per / 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(RouterConstants.singleResultScreenName);
        },
        child: SizedBox(
          height: 210,
          width: 160,
          child: Card(
            child: Column(
              children: [
                ImageDemonstrator(
                  imageProvider: AssetImage("assets/ferrari.png"),
                  height: 160,
                  width: 160,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ferrari",
                        style: Theme.of(context).textTheme.displayLarge,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "%97",
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  color: _calculateColor(97),
                                ),
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
