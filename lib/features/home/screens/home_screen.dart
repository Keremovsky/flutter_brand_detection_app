import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer.dart';
import 'package:flutter_brand_detection_app/features/history/widgets/history_component.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/image_choice_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                    onTap: () {},
                  ),
                  ImageChoiceButton(
                    text: "Dosyadan Seç",
                    imagePath: "assets/take_from_file.png",
                    height: width * 0.65,
                    width: width * 0.45,
                    onTap: () {},
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
