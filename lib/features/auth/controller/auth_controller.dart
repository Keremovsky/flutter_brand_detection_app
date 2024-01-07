import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>((ref) => AuthController(
        authRepository: ref.read(authRepositoryProvider),
        historyController: ref.read(historyControllerProvider.notifier)));

final userModelProvider = StreamProvider<UserModel?>((ref) async* {
  final userModelStream = ref.watch(authControllerProvider);
  yield userModelStream;
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  final HistoryController _historyController;

  AuthController({
    required AuthRepository authRepository,
    required HistoryController historyController,
  })  : _authRepository = authRepository,
        _historyController = historyController,
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
        final userModel = UserModel.fromMap(right);
        state = userModel;
        _historyController.updateHistory(userModel.id);
        context.pop();
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
          Future.delayed(const Duration(milliseconds: 2300)).then((value) {
            context.pop();
          });
          break;
      }
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final control = await _authRepository.signInWithGoogle();

    control.fold(
      (left) {
        switch (left) {
          case "no_selection":
            giveFeedback(context, "Herhangi bir google hesabı seçmediniz.");
            break;
          case "google_sign_in_error":
            giveFeedback(
              context,
              "Google ile giriş yapılırken bir hata meydana geldi!",
            );
            break;
          case "token":
            giveFeedback(context, "Google hesabı doğrulanamadı!");
            break;
          case "already_email":
            giveFeedback(
              context,
              "Lütfen emailiniz ile giriş yapın!",
            );
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
        final userModel = UserModel.fromMap(right);
        state = userModel;
        _historyController.updateHistory(userModel.id);
        context.pop();
      },
    );
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
          Future.delayed(const Duration(milliseconds: 2300)).then(
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
    String id,
    String password,
  ) async {
    final uidb64 = base64Encode(utf8.encode(id));
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
          Future.delayed(const Duration(milliseconds: 2300)).then(
            (value) => context.pop(),
          );
          break;
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    if (state == null) {
      giveFeedback(context, "Giriş yapmadan çıkış yapamazsınız!");
      context.pop();
      return;
    }

    final control = await _authRepository.signOut(state!.registrationType);

    if (mounted) {
      if (control) {
        state = null;
      } else {
        giveFeedback(context, "Hesaptan çıkış yapılamadı!");
      }
      context.pop();
    }
  }
}
