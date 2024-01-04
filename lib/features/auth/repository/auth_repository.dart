import 'package:either_dart/either.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      apiService: ApiService(),
      googleSignIn: GoogleSignIn(),
    ));

class AuthRepository {
  final ApiService _apiService;
  final GoogleSignIn _googleSignIn;

  AuthRepository(
      {required ApiService apiService, required GoogleSignIn googleSignIn})
      : _apiService = apiService,
        _googleSignIn = googleSignIn;

  Future<Either<String, Map<String, dynamic>>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final Map<String, String> headers = {
        "email": email,
        "password": password,
        "registrationType": "email",
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

  Future<Either<String, Map<String, dynamic>>> signInWithGoogle() async {
    try {
      // get google account
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();

      // if user didn't select an account
      if (googleAccount == null) {
        return const Left("no_selection");
      }

      // get google auth
      final googleAuth = await googleAccount.authentication;

      // if id token is null, it means sign in process was not successful
      if (googleAuth.idToken == null) {
        return const Left("google_sign_in_error");
      }

      final Map<String, String> headers = {
        "password": googleAuth.idToken!,
        "registrationType": "google",
      };
      final response = await _apiService.post("login/", headers);

      await _googleSignIn.disconnect();

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
