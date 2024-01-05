import 'dart:io';
import 'dart:ui';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/core/utils/custom_button.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_brand_detection_app/features/image_picker/widgets/raito_selector_dialog.dart';
import 'package:flutter_brand_detection_app/features/search/controller/search_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ImageCropperScreen extends ConsumerStatefulWidget {
  final String path;

  const ImageCropperScreen({super.key, required this.path});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ImageCropperScreenState();
}

class _ImageCropperScreenState extends ConsumerState<ImageCropperScreen> {
  late final CropController cropController;
  late bool isThemeLight;

  @override
  void initState() {
    cropController = CropController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cropController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isThemeLight = isThemeLightFunc(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fotoğraf Kırp",
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
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 170,
              child: CropImage(
                controller: cropController,
                gridCornerSize: 35,
                alwaysMove: true,
                image: Image.file(
                  File(widget.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 80,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      onTap: () {
                        cropController.rotation = CropRotation.up;
                        cropController.aspectRatio = null;
                        cropController.crop = const Rect.fromLTRB(0, 0, 1, 1);
                      },
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(
                        Icons.close,
                        size: ThemeConstants.generalIconSize,
                      ),
                    ),
                    CustomButton(
                      onTap: () async {
                        final newRatio = await showDialog(
                          context: context,
                          builder: (context) {
                            return const RatioSelectorDialog();
                          },
                        );

                        if (newRatio != -1) {
                          cropController.aspectRatio = newRatio;
                          cropController.crop = const Rect.fromLTRB(0, 0, 1, 1);
                        }
                      },
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(
                        Icons.aspect_ratio,
                        size: ThemeConstants.generalIconSize,
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        cropController.rotateLeft();
                      },
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(
                        Icons.rotate_90_degrees_ccw,
                        size: ThemeConstants.generalIconSize,
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        cropController.rotateRight();
                      },
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(
                        Icons.rotate_90_degrees_cw_outlined,
                        size: ThemeConstants.generalIconSize,
                      ),
                    ),
                    CustomButton(
                      onTap: () async {
                        // get image data as bytes
                        final image = await cropController.croppedBitmap();
                        final data = await image.toByteData(
                          format: ImageByteFormat.png,
                        );
                        final bytes = data!.buffer.asUint8List();

                        final userModel = ref.read(authControllerProvider);
                        final id = userModel != null ? userModel.id : -1;

                        await ref
                            .read(searchControllerProvider.notifier)
                            .search(bytes, id);
                        if (mounted) {
                          context.pushReplacementNamed(
                            RouterConstants.resultScreenName,
                          );
                        }
                      },
                      height: 60,
                      width: 60,
                      borderRadius: BorderRadius.circular(100),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: const Icon(
                        Icons.done,
                        size: ThemeConstants.generalIconSize,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
