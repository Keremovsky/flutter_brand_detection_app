import 'package:either_dart/either.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      apiService: ApiService(),
    ));

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<Either<String, Map<String, dynamic>>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final Map<String, String> headers = {
        "email": email,
        "password": password,
      };
      final response = await _apiService.post("login/", headers);

      return Right(response);
    } catch (e) {
      return const Left("error");
    }
  }

  Future<Either<String, Map<String, dynamic>>> registerWithEmail(
    String email,
    String password,
    String name,
  ) async {
    try {
      final Map<String, String> headers = {
        "email": email,
        "password": password,
        "name": name,
        "registrationType": "email",
      };
      final response = await _apiService.post("register/", headers);

      return Right(response);
    } catch (e) {
      return const Left("error");
    }
  }
}
