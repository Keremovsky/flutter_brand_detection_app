import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class HistoryItem extends StatelessWidget {
  final HistoryItemModel historyModel;
  final String imagePath;

  const HistoryItem({
    super.key,
    required this.historyModel,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouterConstants.resultScreenName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Builder(builder: (context) {
          ThemeData currentTheme = Theme.of(context);

          return Material(
            color: isThemeLight(currentTheme)
                ? Palette.mainColor
                : Palette.darkMainColor,
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 120,
              child: Column(
                children: [
                  ImageDemonstrator(
                    imageProvider: AssetImage("assets/ferrari.png"),
                    height: 120,
                    width: 120,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          "Ferrari",
                          style: Theme.of(context).textTheme.displayMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(Icons.more_vert_rounded, size: 24),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
