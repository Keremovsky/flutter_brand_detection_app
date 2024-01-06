import 'package:flutter/widgets.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/feedback/repository/feedback_repository.dart';
import 'package:flutter_brand_detection_app/models/feedback_model.dart';
import 'package:flutter_brand_detection_app/models/request_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

final feedbackControllerProvider =
    StateNotifierProvider<FeedbackController, bool>((ref) => FeedbackController(
          feedbackRepository: ref.read(feedbackRepositoryProvider),
        ));

class FeedbackController extends StateNotifier<bool> {
  final FeedbackRepository _feedbackRepository;

  FeedbackController({required FeedbackRepository feedbackRepository})
      : _feedbackRepository = feedbackRepository,
        super(false);

  Future<void> sendRequest(
    BuildContext context,
    RequestModel requestModel,
    XFile image,
    int id,
  ) async {
    final control =
        await _feedbackRepository.sendRequest(requestModel, image, id);

    if (mounted) {
      switch (control) {
        case "no_user":
          giveFeedback(context, "İstekte bulunmak için lütfen giriş yapın.");
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(context, "İstek başarılı bir şekilde oluşturuldu.");
          Future.delayed(const Duration(milliseconds: 2300))
              .then((value) => context.pop());
          break;
      }
    }
  }

  Future<List<RequestModel>?> getAllRequest(
    BuildContext context,
    int id,
  ) async {
    final control = await _feedbackRepository.getAllRequest(id);

    return control.fold(
      (left) {
        switch (left) {
          case "no_request":
            giveFeedback(context, "Yapılan herhangi bir istek bulunamadı.");
            break;
          case "no_user":
            giveFeedback(
              context,
              "Yaptığınız istekleri görebilmek için lütfen giriş yapın.",
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
      (right) async {
        final responseRequests = right["requests"];

        final List<RequestModel> requests = [];
        for (final request in responseRequests) {
          requests.add(RequestModel.fromMap(request));
        }

        return requests.reversed.toList();
      },
    );
  }

  Future<void> sendFeedback(
    BuildContext context,
    String description,
    int id,
  ) async {
    final control = await _feedbackRepository.sendFeedback(description, id);

    if (mounted) {
      switch (control) {
        case "no_user":
          giveFeedback(
            context,
            "Geri bildirim yapabilmek için lütfen giriş yapın.",
          );
          break;
        case "no_history":
          giveFeedback(
            context,
            "Geri bildirim oluşturmaya çalıştığınız geçmiş arama bulunmamakta.",
          );
          break;
        case "error":
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
          break;
        case "server":
          giveFeedback(context, "Sunucu ile bağlantı kurulamadı!");
          break;
        default:
          giveFeedback(
              context, "Geri bildirim başarılı bir şekilde oluşturuldu.");
          Future.delayed(const Duration(milliseconds: 2300))
              .then((value) => context.pop());
          break;
      }
    }
  }

  Future<List<FeedbackModel>?> getAllFeedback(
    BuildContext context,
    int id,
  ) async {
    final control = await _feedbackRepository.getAllFeedback(id);

    return control.fold(
      (left) {
        switch (left) {
          case "no_user":
            giveFeedback(context,
                "Yaptığınız geri bildirimleri görebilmek için lütfen giriş yapın.");
            break;
          case "no_feedback":
            giveFeedback(
              context,
              "Yapılan herhangi bir geri bildirim bulunamadı.",
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
      (right) async {
        final responseFeedbacks = right["feedbacks"];

        final List<FeedbackModel> feedbacks = [];
        for (final feedback in responseFeedbacks) {
          feedbacks.add(FeedbackModel.fromMap(feedback));
        }

        return feedbacks.reversed.toList();
      },
    );
  }
}
