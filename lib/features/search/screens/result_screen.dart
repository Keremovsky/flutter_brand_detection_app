import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_text_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_item.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text(
                "Aranan Fotoğraf",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              ImageDemonstrator(
                imageProvider: AssetImage("assets/ferrari.png"),
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
              const ResultList(),
              const Spacer(flex: 2),
              Text(
                "Sonuç yanlış mı?",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              CustomTextButton(
                text: Text(
                  "Geri Bildirim Yolla",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                onTap: () {},
                height: 40,
                width: 200,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
