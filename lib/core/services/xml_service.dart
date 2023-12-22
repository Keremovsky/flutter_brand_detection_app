import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xml/xml.dart';

class XmlService {
  final XmlBuilder _xmlBuilder;

  XmlService() : _xmlBuilder = XmlBuilder();

  void downloadXmlFile(BuildContext context) async {
    try {
      // get permission for manage storage
      final permissionStatus = await Permission.manageExternalStorage.request();

      if (permissionStatus.isGranted) {
        // create xml
        _xmlBuilder.processing("xml", 'version="1.0"');
        _xmlBuilder.element("data", nest: () {
          _xmlBuilder.element("example", nest: () {
            _xmlBuilder.attribute("test", "0");
            _xmlBuilder.text("example test");
          });
        });

        // build document of xml and transform it into string
        final xmlString = _xmlBuilder.buildDocument().toXmlString(pretty: true);

        // get file for xml
        const filePath = "/storage/emulated/0/Download/created_xml.xml";
        final file = File(filePath);

        // save xml file
        file.writeAsStringSync(xmlString);

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
        giveFeedback(context, "XML dosyası indirilemedi.");
      }
    }
  }
}
