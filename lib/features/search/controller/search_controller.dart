import 'package:flutter/foundation.dart';
import 'package:flutter_brand_detection_app/features/search/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, bool>((ref) => SearchController(
          searchRepository: ref.read(searchRepositoryProvider),
        ));

class SearchController extends StateNotifier<bool> {
  final SearchRepository _searchRepository;

  SearchController({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(false);

  Future<void> search(Uint8List imageBytes, int id) async {
    final control = await _searchRepository.search(imageBytes, id);

    debugPrint(control);
  }
}
