import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_item.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';

class ResultList extends StatelessWidget {
  final List<ResultModel> resultModels;

  const ResultList({super.key, required this.resultModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: resultModels.length,
        itemBuilder: (context, index) {
          return ResultItem(resultModel: resultModels[index]);
        },
      ),
    );
  }
}
