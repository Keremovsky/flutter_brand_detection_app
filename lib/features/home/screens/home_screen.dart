import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/theme_constants.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer.dart';
import 'package:flutter_brand_detection_app/features/home/widgets/drawer_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffolKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu_rounded,
            size: ThemeConstants.appBarIconSize,
          ),
        ),
      ),
      drawer: const Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: CustomDrawer(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
