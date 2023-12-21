import 'package:riverpod/riverpod.dart';

final feedbackRepositoryProvider = Provider(
  (ref) => FeedbackRepository(),
);

class FeedbackRepository {}
