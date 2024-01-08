import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml/xml.dart';

class XmlService {
  final XmlBuilder _xmlBuilder;

  XmlService() : _xmlBuilder = XmlBuilder();

  void downloadXmlFile(
    BuildContext context,
    List<List<ResultModel>> resultModels,
  ) async {
    try {
      // get permission for manage storage
      final permissionStatus = await Permission.manageExternalStorage.request();

      if (permissionStatus.isGranted) {
        _xmlBuilder.processing('xml', 'version="1.0"');
        _xmlBuilder.element(
          "tüm_geçmiş",
          nest: () {
            for (final resultModel in resultModels) {
              _xmlBuilder.element("geçmiş", nest: () {
                for (final result in resultModel) {
                  _xmlBuilder.element("sonuç", nest: () {
                    _xmlBuilder.element("isim", nest: result.name);
                    _xmlBuilder.element("konum", nest: result.location);
                    _xmlBuilder.element("açıklama", nest: result.description);
                    _xmlBuilder.element("internet_sitesi",
                        nest: result.web ?? "");
                    _xmlBuilder.element("twitter", nest: result.twitter ?? "");
                    _xmlBuilder.element(
                      "benzerlik_yüzdesi",
                      nest: result.similarity,
                    );
                  });
                }
              });
            }
          },
        );

        // build document of xml and transform it into string
        final xmlString = _xmlBuilder.buildDocument().toXmlString(pretty: true);

        // get file for xml
        final now = DateTime.now();
        final filename = "geçmiş${formatDate(now)}";
        final filePath = "/storage/emulated/0/Download/$filename.xml";
        final file = File(filePath);

        // save xml file
        file
          ..createSync(recursive: true)
          ..writeAsStringSync(xmlString);

        if (context.mounted) {
          giveFeedback(context, "XML dosyası başarıyla indirildi.");
        }
      } else {
        if (context.mounted) {
          giveFeedback(context, "Dosya izni verilmedi.");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      if (context.mounted) {
        giveFeedback(context, "XML dosyası indirilirken bir hata oluştu.");
      }
    }
  }
}
