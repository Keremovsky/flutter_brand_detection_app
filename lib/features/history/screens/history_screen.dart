import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/error_text.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/delete_all_history_items_alert.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
        child: ref.watch(allHistoryItemsProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "(>'-'<)",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Geçmiş hala bomboş",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Text(data[index].id.toString());
              },
            );
          },
          error: (error, stackTree) {
            return const Center(
              child: ErrorText(text: "Bilinmeyen bir hata oluştu. :("),
            );
          },
          loading: () {
            return const CustomCircularProgressIndicator(
              size: 50,
              color: Palette.mainColor,
            );
          },
        ),
      ),
    );
  }
}
