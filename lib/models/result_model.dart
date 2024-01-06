// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResultModel {
  final int id;
  final String name;
  final String location;
  final String description;
  final String web;
  final String twitter;
  final String image;
  final double similarity;

  ResultModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.web,
    required this.twitter,
    required this.image,
    required this.similarity,
  });

  ResultModel copyWith({
    int? id,
    String? name,
    String? location,
    String? description,
    String? web,
    String? twitter,
    String? image,
    double? similarity,
  }) {
    return ResultModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      web: web ?? this.web,
      twitter: twitter ?? this.twitter,
      image: image ?? this.image,
      similarity: similarity ?? this.similarity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'web': web,
      'twitter': twitter,
      'image': image,
      'similarity': similarity,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      id: map['id'] as int,
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      web: map['web'] as String,
      twitter: map['twitter'] as String,
      image: map['image'] as String,
      similarity: map['similarity'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) =>
      ResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResultModel(id: $id, name: $name, location: $location, description: $description, web: $web, twitter: $twitter, image: $image, similarity: $similarity)';
  }

  @override
  bool operator ==(covariant ResultModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.location == location &&
        other.description == description &&
        other.web == web &&
        other.twitter == twitter &&
        other.image == image &&
        other.similarity == similarity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        description.hashCode ^
        web.hashCode ^
        twitter.hashCode ^
        image.hashCode ^
        similarity.hashCode;
  }
}
