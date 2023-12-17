import 'package:flutter_brand_detection_app/features/backend/repository/backend_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final backendControllerProvider =
    StateNotifierProvider<BackendController, bool>((ref) => BackendController(
          backendRepository: ref.read(backendRepositoryProvider),
        ));

class BackendController extends StateNotifier<bool> {
  final BackendRepository _backendRepository;

  BackendController({required backendRepository})
      : _backendRepository = backendRepository,
        super(false);
}
