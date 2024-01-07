import 'package:either_dart/either.dart';
import 'package:flutter_brand_detection_app/core/constants/secret_constants.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      apiService: ApiService(),
      googleSignIn: GoogleSignIn(),
    ));

class AuthRepository {
  final ApiService _apiService;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required ApiService apiService,
    required GoogleSignIn googleSignIn,
  })  : _apiService = apiService,
        _googleSignIn = googleSignIn;

  Future<Map<String, dynamic>?> autoLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final registrationType = prefs.getString(SecretConstants.regisTypeKey);

      if (registrationType != null) {
        if (registrationType == "google") {
          final GoogleSignInAccount? googleAccount =
              await _googleSignIn.signIn();
          final googleAuth = await googleAccount!.authentication;

          final Map<String, String> headers = {
            "password": googleAuth.idToken!,
            "registrationType": "google",
          };
          final response = await _apiService.post(
            "sign-in-with-google/",
            headers: headers,
          );

          return response;
        } else {
          final email = prefs.getString(SecretConstants.emailKey);
          final password = prefs.getString(SecretConstants.passwordKey);

          final Map<String, String> headers = {
            "email": email!,
            "password": password!,
            "registrationType": "email",
          };
          final response = await _apiService.post(
            "login/",
            headers: headers,
          );

          return response;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Either<String, Map<String, dynamic>>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Map<String, String> headers = {
        "email": email,
        "password": password,
        "registrationType": "email",
      };
      final response = await _apiService.post("login/", headers: headers);

      if (response.containsKey("response")) {
        return Left(response["response"]);
      }

      await prefs.setString(SecretConstants.regisTypeKey, "email");
      await prefs.setString(SecretConstants.emailKey, email);
      await prefs.setString(SecretConstants.passwordKey, password);
      return Right(response);
    } catch (e) {
      return const Left("server");
    }
  }

  Future<Either<String, Map<String, dynamic>>> signInWithGoogle() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
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
      final response = await _apiService.post(
        "sign-in-with-google/",
        headers: headers,
      );

      if (response.containsKey("response")) {
        return Left(response["response"]);
      }

      await prefs.setString(SecretConstants.regisTypeKey, "google");
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
      final response = await _apiService.post("register/", headers: headers);

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
        headers: headers,
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
        headers: headers,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<bool> signOut(String registrationType) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (registrationType == "google") {
        await _googleSignIn.signOut();
      }
      final isDeleted = prefs.remove(SecretConstants.regisTypeKey);

      return isDeleted;
    } catch (e) {
      return false;
    }
  }
}
