import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/assets_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_circular_progress_indicator.dart';
import 'package:flutter_brand_detection_app/core/utils/error_widget.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/core/utils/list_item.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/no_user_history_alert.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
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
        child: ref.watch(userModelProvider).when(
          data: (data) {
            if (data == null) {
              return const Center(child: NoUserHistoryAlert());
            } else {
              final user = ref.read(authControllerProvider)!;
              return ref.watch(historyStreamProvider).when(
                    data: (data) {
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
                                  RouterConstants.resultScreenName,
                                  extra: [
                                    data[index],
                                    imageBytes,
                                  ],
                                );
                              }
                            },
                            image: NetworkImage(
                              SecretConstants.mainUrl +
                                  data[index][0].searchedImage!,
                            ),
                            model: data[index],
                            subChild: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomButton(
                                  backgroundColor: Palette.red,
                                  onTap: () async {
                                    // delete history item
                                    final isDeleted = await ref
                                        .read(
                                            historyControllerProvider.notifier)
                                        .deleteHistory(
                                          context,
                                          user.id,
                                          data[index][0].id.toString(),
                                        );

                                    if (isDeleted) {
                                      // update history in app
                                      await ref
                                          .read(historyControllerProvider
                                              .notifier)
                                          .updateHistory(user.id);
                                    }
                                  },
                                  height: 35,
                                  width: 35,
                                  child: const Icon(
                                    Icons.remove,
                                    size: ThemeConstants.iconButtonIconSize,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                CustomButton(
                                  backgroundColor: data[index][0].isSaved!
                                      ? Palette.yellow
                                      : Palette.green,
                                  onTap: () async {
                                    final isHandled = await ref
                                        .read(
                                            historyControllerProvider.notifier)
                                        .handleSaveHistory(
                                          context,
                                          user.id,
                                          data[index][0].id.toString(),
                                        );

                                    if (isHandled) {
                                      await ref
                                          .read(historyControllerProvider
                                              .notifier)
                                          .updateHistory(user.id);
                                    }
                                  },
                                  height: 35,
                                  width: 35,
                                  child: Icon(
                                    data[index][0].isSaved!
                                        ? Icons.star
                                        : Icons.add,
                                    size: ThemeConstants.iconButtonIconSize,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () {
                      return const CustomCircularProgressIndicator(
                        size: 50,
                        color: Palette.blue,
                      );
                    },
                    error: (error, stackTrace) => const ErrorAlertWidget(),
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
        ),
      ),
    );
  }
}
