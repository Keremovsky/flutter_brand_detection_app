import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class MainHistoryItem extends StatelessWidget {
  final HistoryItemModel historyItemModel;

  const MainHistoryItem({super.key, required this.historyItemModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(RouterConstants.resultScreenName);
        },
        child: Material(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                ImageDemonstrator(
                  imageProvider: AssetImage("assets/ferrari.png"),
                  height: 100,
                  width: 100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 120,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 5,
                        child: Text(
                          "Ferrari",
                          style: Theme.of(context).textTheme.displayLarge,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 30,
                        child: Text(historyItemModel.searchDate.toString()),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              backgroundColor: Palette.red,
                              onTap: () {},
                              height: 30,
                              width: 30,
                              borderRadius: BorderRadius.circular(100),
                              child: const Icon(
                                Icons.remove,
                                size: ThemeConstants.iconButtonIconSize,
                              ),
                            ),
                            const SizedBox(width: 10),
                            historyItemModel.isSaved
                                ? CustomButton(
                                    backgroundColor: Palette.yellow,
                                    onTap: () {},
                                    height: 30,
                                    width: 30,
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(
                                      Icons.star,
                                      size: ThemeConstants.iconButtonIconSize,
                                    ),
                                  )
                                : CustomButton(
                                    backgroundColor: Palette.green,
                                    onTap: () {},
                                    height: 30,
                                    width: 30,
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(
                                      Icons.add,
                                      size: ThemeConstants.iconButtonIconSize,
                                    ),
                                  ),
                          ],
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
