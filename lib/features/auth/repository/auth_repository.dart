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

      if (response.containsKey("response")) {
        return Left(response["response"]);
      }

      return Right(response);
    } catch (e) {
      return const Left("server");
    }
  }

  Future<String> registerWithEmail(
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

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<String> resetPasswordRequest(String email) async {
    try {
      final Map<String, String> headers = {
        "email": email,
      };

      final response = await _apiService.post(
        "reset-password-request/",
        headers,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<String> resetPasswordConfirm(
    String token,
    String uidb64,
    String password,
  ) async {
    try {
      final Map<String, String> headers = {
        "password": password,
      };

      final response = await _apiService.post(
        "reset-password-confirm/$uidb64/$token/",
        headers,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }
}
