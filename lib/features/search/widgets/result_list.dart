import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_item.dart';

class ResultList extends StatelessWidget {
  const ResultList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return const ResultItem();
        },
      ),
    );
  }
}
