import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/constants/router_constants.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_brand_detection_app/features/history/controller/history_controller.dart';
import 'package:flutter_brand_detection_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>((ref) => AuthController(
          authRepository: ref.read(authRepositoryProvider),
          historyController: ref.read(historyControllerProvider.notifier),
          internetConnectionChecker: InternetConnectionChecker(),
        ));

final userModelProvider = StreamProvider<UserModel?>((ref) async* {
  final userModelStream = ref.watch(authControllerProvider);
  yield userModelStream;
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;
  final HistoryController _historyController;
  final InternetConnectionChecker _internetConnectionChecker;

  AuthController(
      {required AuthRepository authRepository,
      required HistoryController historyController,
      required InternetConnectionChecker internetConnectionChecker})
      : _authRepository = authRepository,
        _historyController = historyController,
        _internetConnectionChecker = internetConnectionChecker,
        super(null);

  Future<bool> autoLogin() async {
    final isConnected = await _internetConnectionChecker.hasConnection;

    if (!isConnected) {
      return false;
    }

    final control = await _authRepository.autoLogin();

    return control.fold(
      (left) {
        if (left == "server") {
          return false;
        } else {
          return true;
        }
      },
      (right) {
        final userModel = UserModel.fromMap(right);
        state = userModel;
        _historyController.updateHistory(userModel.id);
        return true;
      },
    );
  }

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
      (right) async {
        final userModel = UserModel.fromMap(right);
        state = userModel;
        await _historyController.updateHistory(userModel.id);
        if (mounted) {
          context.pop();
        }
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
        case "google":
          giveFeedback(
            context,
            "Google ile kayıt olan kullanıcılar şifre yenileyemezler.",
          );
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(
            context,
            "Şifre yenileme kodu e-mailinize gönderildi!",
            duration: const Duration(milliseconds: 1500),
          );
          Future.delayed(const Duration(milliseconds: 1800)).then(
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
          if (state != null) {
            state = null;
          }
          giveFeedback(
            context,
            "Şifreniz başarıyla yenilendi!",
            duration: const Duration(milliseconds: 1500),
          );
          Future.delayed(const Duration(milliseconds: 1800)).then(
            (value) => context.pop(),
          );
          break;
      }
    }
  }

  Future<void> changeName(BuildContext context, int id, String newName) async {
    final control = await _authRepository.changeName(id, newName);

    control.fold(
      (left) {
        switch (left) {
          case "no_user":
            giveFeedback(
              context,
              "İsmi değiştirilmeye çalışılan kullanıcı mevcut değil.",
            );
            break;
          case "error":
            giveFeedback(context, "Bilinmeyen bir hata oluştu!");
            break;
          default:
            giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
        }
      },
      (right) {
        giveFeedback(context, "İsminiz başarıyla değiştirildi.");
        final userModel = UserModel.fromMap(right);
        state = userModel;
      },
    );
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
