import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_component.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/image_choice_button.dart';
import 'package:flutter_brand_detection_app/features/image_picker/controller/image_picker_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffolKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            size: ThemeConstants.generalIconSize,
          ),
        ),
      ),
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: CustomDrawer(),
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
                  ImageChoiceButton(
                    text: "Fotoğraf Çek",
                    imagePath: "assets/take_photo.png",
                    height: width * 0.65,
                    width: width * 0.45,
                    onTap: () async {
                      final result = await ref
                          .read(imagePickerControllerProvider.notifier)
                          .takePicture(context);
                      if (result == null) {
                        print("null");
                      } else {
                        print(result.path);
                      }
                    },
                  ),
                  ImageChoiceButton(
                    text: "Dosyadan Seç",
                    imagePath: "assets/take_from_file.png",
                    height: width * 0.65,
                    width: width * 0.45,
                    onTap: () async {
                      final result = await ref
                          .read(imagePickerControllerProvider.notifier)
                          .getImageGallery(context);

                      if (result == null) {
                        print("null");
                      } else {
                        print(result.path);
                      }
                    },
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
