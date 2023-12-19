import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod/riverpod.dart';

final imagePickerRepositoryProvider = Provider(
  (ref) => ImagePickerRepository(),
);

class ImagePickerRepository {
  final ImagePicker _imagePicker;

  ImagePickerRepository() : _imagePicker = ImagePicker();

  Future<Either<String, XFile>> takePicture() async {
    try {
      final permissionStatus = await Permission.camera.request();
      if (permissionStatus.isGranted) {
        final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.camera,
        );

        if (image != null) {
          return Right(image);
        } else {
          return const Left("no_selection");
        }
      } else {
        return const Left("no_permission");
      }
    } catch (e) {
      debugPrint(e.toString());
      return const Left("error");
    }
  }

  Future<Either<String, XFile>> getImageGallery() async {
    try {
      final permissionStatus = await Permission.photos.request();
      if (permissionStatus.isGranted) {
        final XFile? image = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );

        if (image != null) {
          return Right(image);
        } else {
          return const Left("no_selection");
        }
      } else {
        return const Left("no_permission");
      }
    } catch (e) {
      return const Left("error");
    }
  }
}
