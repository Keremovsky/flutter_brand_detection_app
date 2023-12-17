import 'package:flutter_brand_detection_app/features/history/repository/history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvier =
    StateNotifierProvider<HistoryController, bool>((ref) => HistoryController(
          historyRepository: ref.read(historyRepositoryProvider),
        ));

class HistoryController extends StateNotifier<bool> {
  final HistoryRepository _historyRepository;

  HistoryController({required historyRepository})
      : _historyRepository = historyRepository,
        super(false);
}
