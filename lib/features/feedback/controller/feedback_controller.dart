import 'package:flutter_brand_detection_app/features/feedback/repository/feedback_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedbackControllerProvider =
    StateNotifierProvider<FeedbackController, bool>((ref) => FeedbackController(
          feedbackRepository: ref.read(feedbackRepositoryProvider),
        ));

class FeedbackController extends StateNotifier<bool> {
  final FeedbackRepository _feedbackRepository;

  FeedbackController({required FeedbackRepository feedbackRepository})
      : _feedbackRepository = feedbackRepository,
        super(false);
}
