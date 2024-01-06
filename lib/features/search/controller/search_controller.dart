import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/search/repository/search_repository.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
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

  Future<List<ResultModel>?> search(
      BuildContext context, Uint8List imageBytes, int id) async {
    final control = await _searchRepository.search(imageBytes, id);

    return control.fold(
      (left) {
        switch (left) {
          case "search_error":
            giveFeedback(context, "Arama yapılırken bir hata meydana geldi.");
            break;
          case "image_error":
            giveFeedback(
              context,
              "Fotoğraf formatı ile alakalı bir hata meydana geldi.",
            );
            break;
          case "error":
            giveFeedback(context, "Bilinmeyen bir hata oluştu!");
            break;
          default:
            giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
            break;
        }

        return null;
      },
      (right) {
        final resultsResponse = right["results"];

        final List<ResultModel> results = [];
        for (final result in resultsResponse) {
          results.add(ResultModel.fromMap(result));
        }

        return results;
      },
    );
  }
}
