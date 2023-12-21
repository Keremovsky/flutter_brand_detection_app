import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/forget_password_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/login_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/register_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/reset_password_screen.dart';
import 'package:flutter_brand_detection_app/features/feedback/screens/feedback_screen.dart';
import 'package:flutter_brand_detection_app/features/history/screens/history_screen.dart';
import 'package:flutter_brand_detection_app/features/home/screens/home_screen.dart';
import 'package:flutter_brand_detection_app/features/search/screens/result_screen.dart';
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
        name: RouterConstants.resultScreenName,
        path: RouterConstants.resultScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ResultScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.feedbackScreenName,
        path: RouterConstants.feedbackScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: FeedbackScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.loginScreenName,
        path: RouterConstants.loginScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.registerScreenName,
        path: RouterConstants.registerScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: RegisterScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.forgetPasswordScreenName,
        path: RouterConstants.forgetPasswordScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ForgetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.resetPasswordScreenName,
        path: RouterConstants.resetPasswordScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ResetPasswordScreen(),
          );
        },
      ),
    ],
  );
}
