import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:riverpod/riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
      apiService: ApiService(),
    ));

class AuthRepository {
  final ApiService _apiService;

  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  Future<Either<String, Map<String, dynamic>>> login(
    String email,
    String password,
  ) async {
    try {
      // get key with sha-256
      final Uint8List bytes = utf8.encode(password);
      final Digest key = sha256.convert(bytes);

      final Map<String, String> headers = {
        "email": email,
        "password": key.toString(),
      };
      final response = await _apiService.post("login/", headers);

      return Right(response);
    } catch (e) {
      debugPrint(e.toString());
      return const Left("error");
    }
  }
}
