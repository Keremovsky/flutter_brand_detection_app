import 'package:flutter/widgets.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/history/repository/history_repository.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider =
    StateNotifierProvider<HistoryController, List<List<ResultModel>>>(
  (ref) =>
      HistoryController(historyRepository: ref.read(historyRepositoryProvider)),
);

final historyStreamProvider =
    StreamProvider<List<List<ResultModel>>>((ref) async* {
  final historyStream = ref.watch(historyControllerProvider);
  yield historyStream;
});

class HistoryController extends StateNotifier<List<List<ResultModel>>> {
  final HistoryRepository _historyRepository;

  HistoryController({required HistoryRepository historyRepository})
      : _historyRepository = historyRepository,
        super([]);

  Future<void> updateHistory(int id) async {
    final control = await _historyRepository.updateHistory(id);

    if (control != null) {
      final histories = control["histories"];

      final List<List<ResultModel>> historyState = [];
      for (final history in histories) {
        final List<ResultModel> results = [];
        for (final result in history) {
          results.add(ResultModel.fromMap(result));
        }

        historyState.add(results);
      }

      state = historyState;
    }
  }

  Future<void> deleteHistory(
      BuildContext context, int id, String historyId) async {
    final control = await _historyRepository.deleteHistory(id, historyId);

    if (mounted) {
      switch (control) {
        case "no_access":
          giveFeedback(
            context,
            "Geri bildirimi silebilmek için lütfen doğru kullanıcı ile giriş yapın.",
          );
          break;
        case "no_user":
          giveFeedback(
            context,
            "Yaptığınız geri bildirimleri silebilmek için lütfen giriş yapın.",
          );
          break;
        case "no_history":
          giveFeedback(context, "Silmeye çalıştığınız geçmiş bulunmamaktadır.");
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
      }
    }
  }
}
