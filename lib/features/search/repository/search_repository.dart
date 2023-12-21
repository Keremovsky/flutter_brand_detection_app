import 'package:riverpod/riverpod.dart';

final searchRepositoryProvider = Provider(
  (ref) => SearchRepository(),
);

class SearchRepository {}
