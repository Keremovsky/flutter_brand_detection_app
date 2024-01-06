import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_list.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';

class FeedbackScreen extends StatelessWidget {
  final List<ResultModel> resultModels;

  const FeedbackScreen({super.key, required this.resultModels});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Text(
              "Aranan Fotoğraf",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            ImageDemonstrator(
              imageProvider: const AssetImage("assets/ferrari.png"),
              height: 200,
              width: 200,
              borderRadius: BorderRadius.circular(10),
            ),
            const Spacer(flex: 1),
            Text(
              "Sonuçlar",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            ResultList(resultModels: resultModels),
            const Spacer(flex: 2),
            // Text(
            //   feedbackModel.description,
            //   style: Theme.of(context).textTheme.displayLarge,
            // ),
          ],
        ),
      ),
    );
  }
}
