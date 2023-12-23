import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/features/search/widgets/result_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  late final ImageProvider xLogoProvider;
  late final ImageProvider googleLogoProvider;
  late final ImageProvider xmlLogoProvider;
  late final ImageProvider excelLogoProvider;

  @override
  void initState() {
    super.initState();
    xLogoProvider = const AssetImage("assets/x_logo.png");
    googleLogoProvider = const AssetImage("assets/google_logo.png");
    xmlLogoProvider = const AssetImage("assets/xml_logo.png");
    excelLogoProvider = const AssetImage("assets/excel_logo.png");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // load images to the cache
    precacheImage(xLogoProvider, context);
    precacheImage(googleLogoProvider, context);
    precacheImage(xmlLogoProvider, context);
    precacheImage(excelLogoProvider, context);
  }

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
              CustomButton(
                onTap: () {},
                height: 40,
                width: 200,
                borderRadius: BorderRadius.circular(10),
                child: Text(
                  "Geri Bildirim Yolla",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
