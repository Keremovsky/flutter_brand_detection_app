import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_item.dart';
import 'package:go_router/go_router.dart';

class HistoryComponent extends StatefulWidget {
  const HistoryComponent({super.key});

  @override
  State<HistoryComponent> createState() => _HistoryComponentState();
}

class _HistoryComponentState extends State<HistoryComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () =>
                    context.pushNamed(RouterConstants.historyScreenName),
                child: Text(
                  "Geçmiş",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return const HistoryItem(
                  text: "Ferrari",
                  imagePath: "assets/ferrari.png",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
