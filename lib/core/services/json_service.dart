import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:permission_handler/permission_handler.dart';

class JsonService {
  void downloadJsonFile(
      BuildContext context, List<List<ResultModel>> resultModels) async {
    try {
      // get permission for manage storage
      final permissionStatus = await Permission.manageExternalStorage.request();

      if (permissionStatus.isGranted) {
        final jsonStringData = jsonEncode(resultModels);
        final formattedJson = _formatJson(jsonStringData);

        // get file for json
        final now = DateTime.now();
        final filename = "geçmiş${formatDate(now)}";
        final filePath = "/storage/emulated/0/Download/$filename.json";
        final file = File(filePath);

        await file.writeAsString(formattedJson);

        if (context.mounted) {
          giveFeedback(context, "JSON dosyası başarıyla indirildi.");
        }
      } else {
        if (context.mounted) {
          giveFeedback(context, "Dosya izni verilmedi.");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        giveFeedback(context, "JSON dosyası indirilirken bir hata oluştu.");
      }
    }
  }
}

String _formatJson(String jsonStringData) {
  final map = jsonDecode(jsonStringData);

  final result = [];
  for (final ma in map) {
    final sub = [];
    for (final m in ma) {
      final a = jsonDecode(m) as Map<String, dynamic>;

      a.remove("id");
      a.remove("searchedImage");
      a.remove("image");
      a.remove("isSaved");
      a.remove("feedbackDescription");

      sub.add(a);
    }
    result.add(sub);
  }

  return jsonEncode(result);
}
