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
import 'package:flutter_brand_detection_app/features/history/widgets/delete_all_history_items_alert.dart';
import 'package:flutter_brand_detection_app/core/utils/list_item.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/no_user_history_alert.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final ResultModel historyItemModel = ResultModel(
    id: 0,
    name: "name",
    image: "",
    description: "description",
    location: "location",
    web: "web",
    twitter: "twitter",
    similarity: 95,
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
        child: ref.watch(userModelProvider).when(
          data: (data) {
            if (data == null) {
              return const Center(child: NoUserHistoryAlert());
            } else {
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
                                SecretConstants.mainUrl +
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
                                  onTap: () {},
                                  height: 35,
                                  width: 35,
                                  child: const Icon(
                                    Icons.remove,
                                    size: ThemeConstants.iconButtonIconSize,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                data[index][0].isSaved!
                                    ? CustomButton(
                                        backgroundColor: Palette.yellow,
                                        onTap: () {},
                                        height: 35,
                                        width: 35,
                                        child: const Icon(
                                          Icons.star,
                                          size:
                                              ThemeConstants.iconButtonIconSize,
                                        ),
                                      )
                                    : CustomButton(
                                        backgroundColor: Palette.green,
                                        onTap: () {},
                                        height: 35,
                                        width: 35,
                                        child: const Icon(
                                          Icons.add,
                                          size:
                                              ThemeConstants.iconButtonIconSize,
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
