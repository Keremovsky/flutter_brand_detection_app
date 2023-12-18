import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_item.dart';
import 'package:go_router/go_router.dart';

class HistoryComponent extends StatefulWidget {
  final bool isSavedOnes;
  final double size;

  const HistoryComponent(
      {super.key, required this.size, required this.isSavedOnes});

  @override
  State<HistoryComponent> createState() => _HistoryComponentState();
}

class _HistoryComponentState extends State<HistoryComponent> {
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
                onTap: () =>
                    context.pushNamed(RouterConstants.historyScreenName),
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
                  text: "Ferrari",
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
