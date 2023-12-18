import 'package:riverpod/riverpod.dart';

final historyRepositoryProvider = Provider(
  (ref) => HistoryRepository(),
);

class HistoryRepository {}
