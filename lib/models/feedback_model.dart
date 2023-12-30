// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FeedbackModel {
  final int id;
  final int resultId;
  final String description;

  FeedbackModel({
    required this.id,
    required this.resultId,
    required this.description,
  });

  FeedbackModel copyWith({
    int? id,
    int? resultId,
    String? description,
  }) {
    return FeedbackModel(
      id: id ?? this.id,
      resultId: resultId ?? this.resultId,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'resultId': resultId,
      'description': description,
    };
  }

  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'] as int,
      resultId: map['resultId'] as int,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackModel.fromJson(String source) =>
      FeedbackModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FeedbackModel(id: $id, resultId: $resultId, description: $description)';

  @override
  bool operator ==(covariant FeedbackModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.resultId == resultId &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ resultId.hashCode ^ description.hashCode;
}
