import 'package:flutter_brand_detection_app/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) => AuthController(
          authRepository: ref.read(authRepositoryProvider),
        ));

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required authRepository})
      : _authRepository = authRepository,
        super(false);
}
