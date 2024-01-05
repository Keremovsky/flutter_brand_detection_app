import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils/image_demonstrator.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_list.dart';
import 'package:flutter_brand_detection_app/features/image_picker/controller/image_picker_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late bool isThemeLight;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    isThemeLight = isThemeLightFunc(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: CustomDrawer(
            refresh: () {
              setState(() {});
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: ThemeConstants.screenPadding,
          child: Column(
            children: [
              const HistoryComponent(isSavedOnes: false),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    onTap: () async {
                      final result = await ref
                          .read(imagePickerControllerProvider.notifier)
                          .takePicture(context);

                      if (result != null) {
                        if (mounted) {
                          context.pushNamed(
                            RouterConstants.imageCropperScreenName,
                            extra: result.path,
                          );
                        }
                      }
                    },
                    height: width * 0.6,
                    width: width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ImageDemonstrator(
                            imageProvider: isThemeLight
                                ? const AssetImage(
                                    "assets/take_photo_black.png")
                                : const AssetImage(
                                    "assets/take_photo_white.png"),
                          ),
                          const Spacer(),
                          Text(
                            "Fotoğraf Çek",
                            style: Theme.of(context).textTheme.displayLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () async {
                      final result = await ref
                          .read(imagePickerControllerProvider.notifier)
                          .getImageGallery(context);

                      if (result != null) {
                        if (mounted) {
                          context.pushNamed(
                            RouterConstants.imageCropperScreenName,
                            extra: result.path,
                          );
                        }
                      }
                    },
                    height: width * 0.6,
                    width: width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          ImageDemonstrator(
                            imageProvider: isThemeLight
                                ? const AssetImage(
                                    "assets/take_from_file_black.png")
                                : const AssetImage(
                                    "assets/take_from_file_white.png"),
                          ),
                          const Spacer(),
                          Text(
                            "Dosyadan Seç",
                            style: Theme.of(context).textTheme.displayLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
