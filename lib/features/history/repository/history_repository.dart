import 'package:flutter_brand_detection_app/core/services/api_service.dart';
import 'package:riverpod/riverpod.dart';

final historyRepositoryProvider = Provider((ref) => HistoryRepository(
      apiService: ApiService(),
    ));

class HistoryRepository {
  final ApiService _apiService;

  HistoryRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<Map<String, dynamic>?> updateHistory(int id) async {
    try {
      final response = await _apiService.get("get-all-history/$id/");

      if (response.containsKey("histories")) {
        return response;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> deleteHistory(int id, String historyId) async {
    try {
      final headers = {"id": historyId};

      final response = await _apiService.post(
        "delete-history/$id/",
        headers: headers,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }

  Future<String> handleSaveHistory(int id, String historyId) async {
    try {
      final headers = {"id": historyId};

      final response = await _apiService.post(
        "handle-save-history/$id/",
        headers: headers,
      );

      return response["response"];
    } catch (e) {
      return "server";
    }
  }
}
