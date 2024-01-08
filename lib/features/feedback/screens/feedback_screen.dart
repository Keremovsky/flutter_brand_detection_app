import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_list.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class FeedbackScreen extends StatefulWidget {
  final List<ResultModel> resultModels;
  final Uint8List imageBytes;

  const FeedbackScreen({
    super.key,
    required this.resultModels,
    required this.imageBytes,
  });

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late bool isThemeLight;

  Color _getColor() {
    if (isThemeLight) {
      return Palette.softBlue;
    } else {
      return Palette.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    isThemeLight = isThemeLightFunc(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              Text(
                "Aranan Fotoğraf",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              ImageDemonstrator(
                imageProvider: MemoryImage(widget.imageBytes),
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
              ResultList(resultModels: widget.resultModels),
              const Spacer(flex: 2),
              Material(
                color: _getColor(),
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.resultModels[0].feedbackDescription!,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
