import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_brand_detection_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>((ref) => AuthController(
          authRepository: ref.read(authRepositoryProvider),
        ));

final userModelProvider = StreamProvider<UserModel?>((ref) async* {
  final userModelStream = ref.watch(authControllerProvider);
  yield userModelStream;
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(null);

  Future<void> loginWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    final control = await _authRepository.loginWithEmail(email, password);

    control.fold(
      (left) {
        switch (left) {
          case "email":
            giveFeedback(context, "E-mail kayıtlı değil.");
            break;
          case "password":
            giveFeedback(context, "Şifre yanlış!");
            break;
          case "server":
            giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
            break;
          default:
            giveFeedback(context, "Bilinmeyen bir hata oluştu!");
            break;
        }
      },
      (right) {
        // final userModel = UserModel.fromMap(right);
        debugPrint(right.toString());
      },
    );
  }

  Future<void> registerWithEmail(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    final control = await _authRepository.registerWithEmail(
      email,
      password,
      name,
    );

    if (mounted) {
      switch (control) {
        case "email":
          giveFeedback(context, "Bu e-mail ile kayıtlı bir kullanıcı mevcut.");
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(context, "Hesabınız başarılıyla oluşturuldu!");
          await Future.delayed(const Duration(milliseconds: 2400));
          if (mounted) {
            context.pop();
          }
          break;
      }
    }
  }

  Future<void> resetPasswordRequest(BuildContext context, String email) async {
    final control = await _authRepository.resetPasswordRequest(email);

    if (mounted) {
      switch (control) {
        case "email":
          giveFeedback(
            context,
            "Bu e-mail ile kayıtlı bir kullanıcı mevcut değil.",
          );
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(context, "Şifre yenileme kodu e-mailinize gönderildi!");
          Future.delayed(const Duration(milliseconds: 2400)).then(
            (value) => context.pushReplacementNamed(
              RouterConstants.resetPasswordScreenName,
              extra: control,
            ),
          );
          break;
      }
    }
  }

  Future<void> resetPasswordConfirm(
    BuildContext context,
    String token,
    String userId,
    String password,
  ) async {
    final uidb64 = base64Encode(utf8.encode(userId));
    final control = await _authRepository.resetPasswordConfirm(
      token,
      uidb64,
      password,
    );

    if (mounted) {
      switch (control) {
        case "token":
          giveFeedback(
            context,
            "Şifre yenileme kodu yanlış.",
          );
          break;
        case "no_user":
          giveFeedback(
            context,
            "Bu e-mail ile kayıtlı bir kullanıcı mevcut değil.",
          );
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(context, "Şifreniz başarıyla yenilendi!");
          Future.delayed(const Duration(milliseconds: 2400)).then(
            (value) => context.pop(),
          );
          break;
      }
    }
  }
}
