import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/backend/screens/login_screen.dart';
import 'package:flutter_brand_detection_app/features/history/screens/history_screen.dart';
import 'package:flutter_brand_detection_app/features/home/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: RouterConstants.homeScreenName,
        path: RouterConstants.homeScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HomeScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.historyScreenName,
        path: RouterConstants.historyScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: HistoryScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.authScreenName,
        path: RouterConstants.authScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
    ],
  );
}
