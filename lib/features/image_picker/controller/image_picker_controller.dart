import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/features/image_picker/repository/image_picker_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imagePickerControllerProvider =
    StateNotifierProvider<ImagePickerController, bool>(
        (ref) => ImagePickerController(
              imagePickerRepository: ref.read(imagePickerRepositoryProvider),
            ));

class ImagePickerController extends StateNotifier<bool> {
  final ImagePickerRepository _imagePickerRepository;

  ImagePickerController({required ImagePickerRepository imagePickerRepository})
      : _imagePickerRepository = imagePickerRepository,
        super(false);

  Future<XFile?> takePicture(BuildContext context) async {
    final control = await _imagePickerRepository.takePicture();

    return control.fold(
      (left) {
        if (left == "error") {
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
        } else if (left == "no_permission") {
          giveFeedback(context, "Kamera için izin alınamadı!");
        }
        return null;
      },
      (right) {
        return right;
      },
    );
  }

  Future<XFile?> getImageGallery(BuildContext context) async {
    final control = await _imagePickerRepository.getImageGallery();

    return control.fold(
      (left) {
        if (left == "error") {
          giveFeedback(context, "Bilinmeyen bir hata oluştu!");
        } else if (left == "no_permission") {
          giveFeedback(context, "Dosya ulaşımı için izin alınamadı!");
        }
        return null;
      },
      (right) {
        return right;
      },
    );
  }

  void cropImage(BuildContext context, String imagePath) async {}
}
