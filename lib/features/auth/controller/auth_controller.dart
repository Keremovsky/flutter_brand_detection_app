import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_brand_detection_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final control = _authRepository.loginWithEmail(email, password);

    control.fold(
      (left) {
        giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
      },
      (right) {
        if (right.containsKey("response")) {
          switch (right["response"]) {
            case "email":
              giveFeedback(context, "E-mail kayıtlı değil.");
              break;
            case "password":
              giveFeedback(context, "Şifre yanlış!");
              break;
            default:
              giveFeedback(context, "Bilinmeyen bir hata oluştu!");
              break;
          }
        } else {
          final userModel = UserModel.fromMap(right);
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
    final control = _authRepository.registerWithEmail(email, password, name);

    control.fold(
      (left) {
        giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
      },
      (right) async {
        switch (right["response"]) {
          case "email":
            giveFeedback(
                context, "Bu e-mail ile kayıtlı bir kullanıcı mevcut.");
            break;
          case "error":
            giveFeedback(context, "Bilinmeyen bir hata oluştu!");
            break;
          default:
            giveFeedback(context, "Hesabınız başarılıyla oluşturuldu!");
            break;
        }
      },
    );
  }
}
