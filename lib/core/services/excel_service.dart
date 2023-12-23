import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';

class ExcelService {
  void downloadExcelFile(BuildContext context) {
    try {
      final excel = Excel.createExcel();
      final sheetObject = excel["Sheet1"];

      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = const TextCellValue("test");

      const filePath = "/storage/emulated/0/Download/created_xlsx.xlsx";
      final file = File(filePath);

      final excelEncode = excel.save();
      file
        ..createSync()
        ..writeAsBytesSync(excelEncode!);

      giveFeedback(context, "Excel dosyası başarıyla indirildi.");
    } catch (e) {
      giveFeedback(context, "Excel dosyası indirilirken bir hata oluştu.");
    }
  }
}
