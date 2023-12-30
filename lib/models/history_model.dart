// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class HistoryModel {
  int id;
  DateTime searchDate;
  List<int> resultIds;
  List<String> companyNames;
  List<String> descriptions;
  List<String> countries;
  List<String> websites;
  List<String> twitters;
  List<double> similarityPercentages;
  bool isSaved;

  HistoryModel({
    required this.id,
    required this.searchDate,
    required this.resultIds,
    required this.companyNames,
    required this.descriptions,
    required this.countries,
    required this.websites,
    required this.twitters,
    required this.similarityPercentages,
    required this.isSaved,
  });

  HistoryModel copyWith({
    int? id,
    DateTime? searchDate,
    List<int>? resultIds,
    List<String>? companyNames,
    List<String>? descriptions,
    List<String>? countries,
    List<String>? websites,
    List<String>? twitters,
    List<double>? similarityPercentages,
    bool? isSaved,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      searchDate: searchDate ?? this.searchDate,
      resultIds: resultIds ?? this.resultIds,
      companyNames: companyNames ?? this.companyNames,
      descriptions: descriptions ?? this.descriptions,
      countries: countries ?? this.countries,
      websites: websites ?? this.websites,
      twitters: twitters ?? this.twitters,
      similarityPercentages:
          similarityPercentages ?? this.similarityPercentages,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'searchDate': searchDate.millisecondsSinceEpoch,
      'resultIds': resultIds,
      'companyNames': companyNames,
      'descriptions': descriptions,
      'countries': countries,
      'websites': websites,
      'twitters': twitters,
      'similarityPercentages': similarityPercentages,
      'isSaved': isSaved,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'] as int,
      searchDate: DateTime.fromMillisecondsSinceEpoch(map['searchDate'] as int),
      resultIds: List<int>.from((map['resultIds'] as List<int>)),
      companyNames: List<String>.from((map['companyNames'] as List<String>)),
      descriptions: List<String>.from((map['descriptions'] as List<String>)),
      countries: List<String>.from((map['countries'] as List<String>)),
      websites: List<String>.from((map['websites'] as List<String>)),
      twitters: List<String>.from((map['twitters'] as List<String>)),
      similarityPercentages:
          List<double>.from((map['similarityPercentages'] as List<double>)),
      isSaved: map['isSaved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) =>
      HistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoryItemModel(id: $id, searchDate: $searchDate, resultIds: $resultIds, companyNames: $companyNames, descriptions: $descriptions, countries: $countries, websites: $websites, twitters: $twitters, similarityPercentages: $similarityPercentages, isSaved: $isSaved)';
  }

  @override
  bool operator ==(covariant HistoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.searchDate == searchDate &&
        listEquals(other.resultIds, resultIds) &&
        listEquals(other.companyNames, companyNames) &&
        listEquals(other.descriptions, descriptions) &&
        listEquals(other.countries, countries) &&
        listEquals(other.websites, websites) &&
        listEquals(other.twitters, twitters) &&
        listEquals(other.similarityPercentages, similarityPercentages) &&
        other.isSaved == isSaved;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        searchDate.hashCode ^
        resultIds.hashCode ^
        companyNames.hashCode ^
        descriptions.hashCode ^
        countries.hashCode ^
        websites.hashCode ^
        twitters.hashCode ^
        similarityPercentages.hashCode ^
        isSaved.hashCode;
  }
}
