import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/services/excel_service.dart';
import 'package:flutter_brand_detection_app/core/services/xml_service.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:go_router/go_router.dart';

class SingleResultScreen extends StatefulWidget {
  const SingleResultScreen({super.key});

  @override
  State<SingleResultScreen> createState() => _SingleResultScreenState();
}

class _SingleResultScreenState extends State<SingleResultScreen> {
  late final XmlService xmlService;
  late final ExcelService excelService;

  @override
  void initState() {
    super.initState();
    xmlService = XmlService();
    excelService = ExcelService();
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
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              Text(
                "Sonuç",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 5),
              ImageDemonstrator(
                imageProvider: const AssetImage("assets/ferrari.png"),
                height: 200,
                width: 200,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(height: 15),
              Text(
                "Ferrari",
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const _CustomSizedBox(),
              Text(
                "Official account of #Ferrari, Italian Excellence that makes the world dream.",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const _CustomSizedBox(),
              Text(
                "Maranello | Italy",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      launchURL("https://twitter.com/home?lang=en");
                    },
                    height: 50,
                    width: 70,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Palette.xColor,
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/x_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      launchURL("https://www.google.com");
                    },
                    height: 50,
                    width: 70,
                    borderRadius: BorderRadius.circular(10),
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/google_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      xmlService.downloadXmlFile(context);
                    },
                    height: 50,
                    width: 70,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Palette.xmlOrange,
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/xml_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      excelService.downloadExcelFile(context);
                    },
                    height: 50,
                    width: 70,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Palette.excelGreen,
                    child: const ImageDemonstrator(
                      imageProvider: AssetImage("assets/excel_logo.png"),
                      height: 25,
                      width: 25,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  const _CustomSizedBox();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
