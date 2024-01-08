import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_brand_detection_app/core/services/stroage_service.dart';
import 'package:flutter_brand_detection_app/core/services/theme_service.dart';
import 'package:flutter_brand_detection_app/router.dart';
import 'package:flutter_brand_detection_app/themes/theme_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize storage service
  StorageService();

  // disable swap screen rotation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  final router = AppRouter().router;

  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeServiceProvider);

    return MaterialApp.router(
      title: 'Flutter Brand Detection App',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      routerConfig: router,
    );
  }
}
