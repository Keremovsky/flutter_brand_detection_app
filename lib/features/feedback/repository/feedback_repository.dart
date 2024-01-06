import 'package:either_dart/either.dart';
import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod/riverpod.dart';

final feedbackRepositoryProvider = Provider((ref) => FeedbackRepository(
      apiService: ApiService(),
    ));

class FeedbackRepository {
  final ApiService _apiService;

  FeedbackRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<String> sendRequest(
    RequestModel requestModel,
    XFile image,
    int id,
  ) async {
    try {
      final imageBytes = await image.readAsBytes();

      final headers = requestModel.toMap();
      headers.remove("id");

      final response = await _apiService.post(
        "create-request/$id/",
        headers: headers.map((key, value) => MapEntry(key, value.toString())),
        imageBytes: imageBytes,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<Either<String, Map<String, dynamic>>> getAllRequest(int id) async {
    try {
      final response = await _apiService.get("get-all-request/$id/");

      if (response.containsKey("response")) {
        return Left(response["response"]);
      }

      return Right(response);
    } catch (e) {
      return const Left("server");
    }
  }

  Future<String> sendFeedback(
    String description,
    String historyId,
    int id,
  ) async {
    try {
      final response = await _apiService.post(
        "create-feedback/$id/",
        headers: {
          "historyId": historyId,
          "description": description,
        },
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<Either<String, Map<String, dynamic>>> getAllFeedback(int id) async {
    try {
      final response = await _apiService.get("get-all-feedback/$id/");

      if (response.containsKey("response")) {
        return Left(response["response"]);
      }

      return Right(response);
    } catch (e) {
      return const Left("server");
    }
  }
}
