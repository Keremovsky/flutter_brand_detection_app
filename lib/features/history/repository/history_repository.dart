import 'package:flutter/foundation.dart';
import 'package:flutter_brand_detection_app/core/constants/file_constants.dart';
import 'package:flutter_brand_detection_app/models/history_item_model.dart';
import 'package:flutter_brand_detection_app/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:riverpod/riverpod.dart';

final historyRepositoryProvider = Provider(
  (ref) => HistoryRepository(dir: FileConstants.dir),
);

class HistoryRepository {
  final Store _store;
  late final Box<HistoryItemModel> _box;

  HistoryRepository({required String dir})
      : _store = Store(getObjectBoxModel(), directory: "$dir/history") {
    _box = _store.box<HistoryItemModel>();
  }

  // insert new history item to database
  void insertHistoryItem(HistoryItemModel historyItem) {
    try {
      _box.put(historyItem);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // delete one history item from database with given id
  bool deleteHistoryItem(int id) {
    try {
      _box.remove(id);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  bool deleteAllHistoryItems() {
    try {
      _box.removeAll();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  // get all history items stream
  Stream<List<HistoryItemModel>> getAllHistoryItems() {
    final allHistoryItems = _box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return allHistoryItems;
  }

  // get all saved history items stream
  Stream<List<HistoryItemModel>> getAllSavedHistoryItems() {
    final allSavedHistoryItems = _box
        .query(HistoryItemModel_.isSaved.equals(true))
        .watch(triggerImmediately: true)
        .map((query) => query.find());
    return allSavedHistoryItems;
  }
}
