import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_brand_detection_app/core/constants/assets_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/delete_all_history_items_alert.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/main_history_item.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
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
  late bool isThemeLight;

  @override
  Widget build(BuildContext context) {
    isThemeLight = isThemeLightFunc(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          CustomButton(
            onTap: () {},
            backgroundColor: Colors.transparent,
            elevation: 0,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: isThemeLight
                    ? const AssetImage(AssetsConstants.excelLogoBlack)
                    : const AssetImage(AssetsConstants.excelLogoWhite),
              ),
            ),
          ),
          CustomButton(
            onTap: () {},
            backgroundColor: Colors.transparent,
            elevation: 0,
            borderRadius: BorderRadius.circular(100),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                image: isThemeLight
                    ? const AssetImage(AssetsConstants.xmlLogoBlack)
                    : const AssetImage(AssetsConstants.xmlLogoWhite),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const DeleteAllHistoryItemsAlert();
                  });
            },
            icon: const Icon(
              Icons.delete,
              size: ThemeConstants.generalIconSize,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return MainHistoryItem(historyItemModel: historyItemModel);
          },
        ),
      ),
    );
  }
}
