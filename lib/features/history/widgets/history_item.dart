import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_pop_up_menu.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:go_router/go_router.dart';

class HistoryItem extends StatefulWidget {
  final List<ResultModel> resultModels;
  final String imagePath;

  const HistoryItem({
    super.key,
    required this.resultModels,
    required this.imagePath,
  });

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final imageBytes = await ApiService().getImage(
          widget.resultModels[0].searchedImage!,
        );

        if (mounted) {
          context.pushNamed(
            RouterConstants.resultScreenName,
            extra: [widget.resultModels, imageBytes],
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          width: 120,
          child: Card(
            child: Column(
              children: [
                ImageDemonstrator(
                  imageProvider: NetworkImage(
                    SecretConstants.mainUrl +
                        widget.resultModels[0].searchedImage!,
                  ),
                  height: 120,
                  width: 120,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        widget.resultModels[0].name,
                        style: Theme.of(context).textTheme.displayMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    HistoryPopUpMenuButton(
                      historyId: widget.resultModels[0].id.toString(),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
