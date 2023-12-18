import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/file_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/error_text.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_item.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryComponent extends ConsumerStatefulWidget {
  final bool isSavedOnes;
  final double size;

  const HistoryComponent({
    super.key,
    required this.isSavedOnes,
    required this.size,
  });

  @override
  ConsumerState<HistoryComponent> createState() => _HistoryComponentState();
}

class _HistoryComponentState extends ConsumerState<HistoryComponent> {
  late final AsyncValue<List<HistoryItemModel>> historyProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.isSavedOnes) {
                  } else {
                    context.pushNamed(RouterConstants.historyScreenName);
                  }
                },
                child: Text(
                  widget.isSavedOnes ? "Kaydedilenler" : "Geçmiş",
                  style: widget.size <= 160
                      ? Theme.of(context).textTheme.titleMedium
                      : Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          SizedBox(height: widget.size / 40),
          widget.isSavedOnes
              ? ref.watch(allSavedHistoryItemsProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              "(>'-'<)",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Kaydedilenler bomboş",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(
                            historyModel: data[index],
                            imagePath:
                                "${FileConstants.dir}${FileConstants.historyImageFilePath}/image${data[0].id}.png",
                            size: 3 * widget.size / 5,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTree) {
                    return const Center(
                      child: ErrorText(text: "Bilinmeyen bir hata oluştu. :("),
                    );
                  },
                  loading: () {
                    return const CustomCircularProgressIndicator(
                      size: 50,
                      color: Palette.mainColor,
                    );
                  },
                )
              : ref.watch(allHistoryItemsProvider).when(
                  data: (data) {
                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            Text(
                              "(>'-'<)",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "Geçmiş bomboş",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ],
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HistoryItem(
                            historyModel: data[index],
                            imagePath:
                                "${FileConstants.dir}${FileConstants.historyImageFilePath}/image${data[0].id}.png",
                            size: 3 * widget.size / 5,
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTree) {
                    return const Center(
                      child: ErrorText(text: "Bilinmeyen bir hata oluştu. :("),
                    );
                  },
                  loading: () {
                    return const CustomCircularProgressIndicator(
                      size: 50,
                      color: Palette.mainColor,
                    );
                  },
                ),
        ],
      ),
    );
  }
}
