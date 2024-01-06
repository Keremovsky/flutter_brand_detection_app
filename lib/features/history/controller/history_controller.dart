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
}
