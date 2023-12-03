import 'package:flutter/material.dart';

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
            size: 32,
          ),
        ),
      ),
      drawer: const Drawer(),
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
