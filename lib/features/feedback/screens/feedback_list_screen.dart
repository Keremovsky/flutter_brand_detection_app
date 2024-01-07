import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/list_item.dart';
import 'package:flutter_brand_detection_app/features/feedback/controller/feedback_controller.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FeedbackListScreen extends ConsumerStatefulWidget {
  final int id;

  const FeedbackListScreen({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeedbackListScreenState();
}

class _FeedbackListScreenState extends ConsumerState<FeedbackListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Geri Bildirimlerim",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
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
        child: FutureBuilder(
          future: ref
              .read(feedbackControllerProvider.notifier)
              .getAllFeedback(context, widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomCircularProgressIndicator(
                size: 50,
                color: Palette.blue,
              );
            }

            final data = snapshot.data;

            if (data == null) {
              return const SizedBox();
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ModelListItem(
                    title: data[index][0].name,
                    content: data[index][0].date,
                    onTap: () async {
                      final imageBytes = await ApiService().getImage(
                        data[index][0].searchedImage!,
                      );

                      if (mounted) {
                        context.pushNamed(
                          RouterConstants.feedbackScreenName,
                          extra: [
                            data[index],
                            imageBytes,
                          ],
                        );
                      }
                    },
                    image: NetworkImage(
                      SecretConstants.mainUrl + data[index][0].searchedImage!,
                    ),
                    model: data[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
