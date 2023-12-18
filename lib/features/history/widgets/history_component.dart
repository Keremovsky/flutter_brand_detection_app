import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_item.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
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
  final HistoryItemModel historyItemModel = HistoryItemModel(
    id: 0,
    searchDate: DateTime.now(),
    resultIds: [],
    companyNames: [],
    descriptions: [],
    countries: [],
    timeZones: [],
    websites: [],
    twitters: [],
    similarityPercentages: [],
    isSaved: false,
  );

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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return HistoryItem(
                  historyModel: historyItemModel,
                  imagePath: "assets/ferrari.png",
                  size: 3 * widget.size / 5,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
