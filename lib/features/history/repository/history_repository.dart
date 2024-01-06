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
}
