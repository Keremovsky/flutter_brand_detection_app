import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/forget_password_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/login_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/register_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/reset_password_screen.dart';
import 'package:flutter_brand_detection_app/features/feedback/screens/feedback_list_screen.dart';
import 'package:flutter_brand_detection_app/features/feedback/screens/request_list_screen.dart';
import 'package:flutter_brand_detection_app/features/feedback/screens/send_feedback_screen.dart';
import 'package:flutter_brand_detection_app/features/feedback/screens/send_request_screen.dart';
import 'package:flutter_brand_detection_app/features/history/screens/history_screen.dart';
import 'package:flutter_brand_detection_app/features/home/screens/home_screen.dart';
import 'package:flutter_brand_detection_app/features/home/screens/settings_screen.dart';
import 'package:flutter_brand_detection_app/features/image_picker/screens/image_cropper_screen.dart';
import 'package:flutter_brand_detection_app/features/search/screens/result_screen.dart';
import 'package:flutter_brand_detection_app/features/search/screens/single_result_screen.dart';
import 'package:flutter_brand_detection_app/features/auth/screens/profile_screen.dart';
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
        name: RouterConstants.settingsScreenName,
        path: RouterConstants.settingsScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SettingsScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.sendFeedbackScreenName,
        path: RouterConstants.sendFeedbackScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SendFeedbackScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.sendRequestScreenName,
        path: RouterConstants.sendRequestScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SendRequestScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.feedbackListScreenName,
        path: RouterConstants.feedbackListScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: FeedbackListScreen(),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.requestListScreenName,
        path: RouterConstants.requestListScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: RequestListScreen(),
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
        name: RouterConstants.singleResultScreenName,
        path: RouterConstants.singleResultScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SingleResultScreen(),
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
          final userId = state.extra as String;
          return MaterialPage(
            child: ResetPasswordScreen(userId: userId),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.imageCropperScreenName,
        path: RouterConstants.imageCropperScreenPath,
        pageBuilder: (context, state) {
          final imagePath = state.extra as String;
          return MaterialPage(
            child: ImageCropperScreen(path: imagePath),
          );
        },
      ),
      GoRoute(
        name: RouterConstants.profileScreenName,
        path: RouterConstants.profileScreenPath,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: ProfileScreen(),
          );
        },
      ),
    ],
  );
}
