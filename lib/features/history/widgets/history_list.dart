import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/error_widget.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_item.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/no_history_alert.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/no_user_history_alert.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryComponent extends ConsumerStatefulWidget {
  const HistoryComponent({super.key});

  @override
  ConsumerState<HistoryComponent> createState() => _HistoryComponentState();
}

class _HistoryComponentState extends ConsumerState<HistoryComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(RouterConstants.historyScreenName);
                },
                child: Text(
                  "Geçmiş",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ref.watch(userModelProvider).when(
                data: (data) {
                  if (data == null) {
                    return const NoUserHistoryAlert();
                  } else {
                    return ref.watch(historyStreamProvider).when(
                      data: (data) {
                        if (data.isEmpty) {
                          return const NoHistoryAlert();
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return HistoryItem(
                                  resultModels: data[index],
                                  imagePath: "assets/ferrari.png",
                                );
                              },
                            ),
                          );
                        }
                      },
                      loading: () {
                        return const CustomCircularProgressIndicator(
                          size: 50,
                          color: Palette.blue,
                        );
                      },
                      error: (error, stackTrace) {
                        return const ErrorAlertWidget();
                      },
                    );
                  }
                },
                loading: () {
                  return const CustomCircularProgressIndicator(
                    size: 50,
                    color: Palette.blue,
                  );
                },
                error: (error, stackTrace) => const ErrorAlertWidget(),
              ),
        ],
      ),
    );
  }
}
