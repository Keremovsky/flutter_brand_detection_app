import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class HistoryItem extends StatelessWidget {
  final HistoryItemModel historyModel;
  final String imagePath;
  final double size;

  const HistoryItem({
    super.key,
    required this.historyModel,
    required this.imagePath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: Palette.mainColor,
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: size,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: SizedBox(
                      height: size,
                      width: size,
                      child: Image(image: AssetImage(imagePath))),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: size / 24),
                    Expanded(
                      child: Text(
                        historyModel.companyNames[0],
                        style: size < 110
                            ? const TextStyle(fontSize: 14)
                            : Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.more_vert_rounded, size: size / 5),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
