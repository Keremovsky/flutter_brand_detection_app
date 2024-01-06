// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class FeedbackModel {
  final int id;
  final String image;
  final String date;
  final List<dynamic> resultIds;
  final bool isSaved;
  final String description;

  FeedbackModel({
    required this.id,
    required this.image,
    required this.date,
    required this.resultIds,
    required this.isSaved,
    required this.description,
  });

  FeedbackModel copyWith({
    int? id,
    String? image,
    String? date,
    List<dynamic>? resultIds,
    bool? isSaved,
    String? description,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      image: image ?? this.image,
      date: date ?? this.date,
      resultIds: resultIds ?? this.resultIds,
      isSaved: isSaved ?? this.isSaved,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'date': date,
      'resultIds': resultIds,
      'isSaved': isSaved,
      'description': description,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] as int,
      image: map['image'] as String,
      date: map['date'] as String,
      resultIds: map["resultIds"] as List<dynamic>,
      isSaved: map['isSaved'] as bool,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModel(id: $id, image: $image, date: $date, resultIds: $resultIds, isSaved: $isSaved, description: $description)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.date == date &&
        listEquals(other.resultIds, resultIds) &&
        other.isSaved == isSaved &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        date.hashCode ^
        resultIds.hashCode ^
        isSaved.hashCode ^
        description.hashCode;
  }
}
