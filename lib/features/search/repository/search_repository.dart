import 'dart:typed_data';

import 'package:either_dart/either.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:riverpod/riverpod.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository(
      apiService: ApiService(),
    ));

class SearchRepository {
  final ApiService _apiService;

  SearchRepository({required ApiService apiService}) : _apiService = apiService;

  Future<Either<String, Map<String, dynamic>>> search(
    Uint8List imageBytes,
    int id,
  ) async {
    final response = await _apiService.post(
      "search/$id",
      imageBytes: imageBytes,
    );

    if (response.containsKey("response")) {
      return Left(response["response"]);
    }

    return Right(response);
  }
}
