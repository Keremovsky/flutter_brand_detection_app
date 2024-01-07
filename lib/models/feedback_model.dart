// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class FeedbackModel {
  final int id;
  final int historyId;
  final String image;
  final String date;
  final String description;

  FeedbackModel({
    required this.id,
    required this.historyId,
    required this.image,
    required this.date,
    required this.description,
  });

  FeedbackModel copyWith({
    int? id,
    int? historyId,
    String? image,
    String? date,
    String? description,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      historyId: historyId ?? this.historyId,
      image: image ?? this.image,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'historyId': historyId,
      'image': image,
      'date': date,
      'description': description,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] as int,
      historyId: map['historyId'] as int,
      image: map['image'] as String,
      date: map['date'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeedbackModel(id: $id, historyId: $historyId, image: $image, date: $date, description: $description)';
  }

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.historyId == historyId &&
      other.image == image &&
      other.date == date &&
      other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      historyId.hashCode ^
      image.hashCode ^
      date.hashCode ^
      description.hashCode;
  }
}
