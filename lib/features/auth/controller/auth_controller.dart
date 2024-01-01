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

final userModelProvider = StateProvider<UserModel?>((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController;
});

class AuthController extends StateNotifier<UserModel?> {
  final AuthRepository _authRepository;

  AuthController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(null);

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final control = _authRepository.login(email, password);

    control.fold(
      (left) {
        giveFeedback(context, "Bilinmeyen bir hata oluştu!");
      },
      (right) {
        if (right.containsKey("error")) {
          switch (right["error"]) {
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
          final UserModel userModel = UserModel.fromMap(right);
          state = userModel;
        }
      },
    );
  }
}
