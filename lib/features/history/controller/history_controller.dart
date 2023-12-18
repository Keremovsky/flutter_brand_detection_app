import 'package:flutter/widgets.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/history/repository/history_repository.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider =
    StateNotifierProvider<HistoryController, bool>((ref) => HistoryController(
          historyRepository: ref.read(historyRepositoryProvider),
        ));

final allHistoryItemsProvider = StreamProvider((ref) {
  final historyController = ref.watch(historyControllerProvider.notifier);
  return historyController.getAllHistoryItems();
});

final allSavedHistoryItemsProvider = StreamProvider((ref) {
  final historyController = ref.watch(historyControllerProvider.notifier);
  return historyController.getAllSavedHistoryItems();
});

class HistoryController extends StateNotifier<bool> {
  final HistoryRepository _historyRepository;

  HistoryController({required historyRepository})
      : _historyRepository = historyRepository,
        super(false);

  // insert new history item to database
  void insertHistoryItem(
    List<int> resultIds,
    List<String> companyNames,
    List<String> descriptions,
    List<String> countries,
    List<String> timeZones,
    List<String> websites,
    List<String> twitters,
    List<double> similarityPercentages,
  ) {
    state = true;
    final now = DateTime.now();
    final HistoryItemModel historyItem = HistoryItemModel(
      searchDate: now,
      resultIds: resultIds,
      companyNames: companyNames,
      descriptions: descriptions,
      countries: countries,
      timeZones: timeZones,
      websites: websites,
      twitters: twitters,
      similarityPercentages: similarityPercentages,
      isSaved: false,
    );
    _historyRepository.insertHistoryItem(historyItem);
    state = false;
  }

  // delete one history item from database with given id
  void deleteHistoryItem(int id, BuildContext context) {
    state = true;
    final control = _historyRepository.deleteHistoryItem(id);

    if (control == true) {
      giveFeedback(
        context,
        "Geçmiş arama silindi.",
        const Duration(seconds: 2),
      );
    } else {
      giveFeedback(
        context,
        "Geçmiş silinirken bir hata meydana geldi!",
        const Duration(seconds: 2),
      );
    }
    state = false;
  }

  void deleteAllHistoryItems(BuildContext context) {
    state = true;
    final control = _historyRepository.deleteAllHistoryItems();

    if (control == true) {
      giveFeedback(
        context,
        "Geçmiş aramalar başarıyla silindi!",
        const Duration(seconds: 2),
      );
    } else {
      giveFeedback(
        context,
        "Geçmiş silinirken bir hata meydana geldi!",
        const Duration(seconds: 2),
      );
    }
    state = false;
  }

  // get all history items stream
  Stream<List<HistoryItemModel>> getAllHistoryItems() {
    final allHistoryItems = _historyRepository.getAllHistoryItems();
    return allHistoryItems;
  }

  // get all saved history items stream
  Stream<List<HistoryItemModel>> getAllSavedHistoryItems() {
    final allSavedHistoryItems = _historyRepository.getAllSavedHistoryItems();
    return allSavedHistoryItems;
  }
}
