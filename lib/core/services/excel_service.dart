import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/core/utils_functions.dart';
import 'package:flutter_brand_detection_app/models/result_model.dart';

class ExcelService {
  void downloadExcelFile(
    BuildContext context,
    List<List<ResultModel>> resultModels,
  ) {
    try {
      final excel = Excel.createExcel();
      final sheetObject = excel["Sheet1"];

      _saveToExcel(resultModels, sheetObject);

      final now = DateTime.now();
      final filename = "geçmiş${formatDate(now)}";
      final filePath = "/storage/emulated/0/Download/$filename.xlsx";
      final file = File(filePath);

      final excelEncode = excel.save();
      file
        ..createSync()
        ..writeAsBytesSync(excelEncode!);

      giveFeedback(context, "Excel dosyası başarıyla indirildi.");
    } catch (e) {
      debugPrint(e.toString());
      giveFeedback(context, "Excel dosyası indirilirken bir hata oluştu.");
    }
  }
}

void _saveToExcel(List<List<ResultModel>> resultModels, Sheet sheetObject) {
  int row = 0;
  for (final resultModel in resultModels) {
    for (final result in resultModel) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 0,
            rowIndex: row,
          ))
          .value = TextCellValue(result.name);
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 1,
            rowIndex: row,
          ))
          .value = TextCellValue(result.location);
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 2,
            rowIndex: row,
          ))
          .value = TextCellValue(result.description);
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 3,
            rowIndex: row,
          ))
          .value = TextCellValue(result.web ?? "");
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 4,
            rowIndex: row,
          ))
          .value = TextCellValue(result.twitter ?? "");
      sheetObject
          .cell(CellIndex.indexByColumnRow(
            columnIndex: 5,
            rowIndex: row,
          ))
          .value = TextCellValue(result.similarity.toString());
      row++;
    }
    row++;
  }
}
