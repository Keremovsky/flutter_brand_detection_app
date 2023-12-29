// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

class FeedbackModel {
  final int id;
  final File image;
  final List<int> resultIds;
  final String description;

  FeedbackModel({
    required this.id,
    required this.image,
    required this.resultIds,
    required this.description,
  });

  FeedbackModel copyWith({
    int? id,
    File? image,
    List<int>? resultIds,
    String? description,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      image: image ?? this.image,
      resultIds: resultIds ?? this.resultIds,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'resultIds': resultIds,
      'description': description,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] as int,
      image: map['image'] as File,
      resultIds: List<int>.from((map['resultIds'] as List<int>)),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModel(id: $id, image: $image, resultIds: $resultIds, description: $description)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        listEquals(other.resultIds, resultIds) &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        resultIds.hashCode ^
        description.hashCode;
  }
}
