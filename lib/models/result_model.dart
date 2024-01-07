// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResultModel {
  final int id;
  final String? date;
  final String? searchedImage;
  final String name;
  final String location;
  final String description;
  final String web;
  final String twitter;
  final String image;
  final bool? isSaved;
  final double similarity;
  final String? feedbackDescription;

  ResultModel({
    required this.id,
    this.date,
    this.searchedImage,
    required this.name,
    required this.location,
    required this.description,
    required this.web,
    required this.twitter,
    required this.image,
    this.isSaved,
    required this.similarity,
    this.feedbackDescription,
  });

  ResultModel copyWith({
    int? id,
    String? date,
    String? searchedImage,
    String? name,
    String? location,
    String? description,
    String? web,
    String? twitter,
    String? image,
    bool? isSaved,
    double? similarity,
    String? feedbackDescription,
  }) {
    return ResultModel(
      id: id ?? this.id,
      date: date ?? this.date,
      searchedImage: searchedImage ?? this.searchedImage,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      web: web ?? this.web,
      twitter: twitter ?? this.twitter,
      image: image ?? this.image,
      isSaved: isSaved ?? this.isSaved,
      similarity: similarity ?? this.similarity,
      feedbackDescription: feedbackDescription ?? this.feedbackDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date,
      'searchedImage': searchedImage,
      'name': name,
      'location': location,
      'description': description,
      'web': web,
      'twitter': twitter,
      'image': image,
      'isSaved': isSaved,
      'similarity': similarity,
      'feedbackDescription': feedbackDescription,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      id: map['id'] as int,
      date: map['date'] != null ? map['date'] as String : null,
      searchedImage:
          map['searchedImage'] != null ? map['searchedImage'] as String : null,
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      web: map['web'] as String,
      twitter: map['twitter'] as String,
      image: map['image'] as String,
      isSaved: map['isSaved'] != null ? map['isSaved'] as bool : null,
      similarity: map['similarity'] as double,
      feedbackDescription: map['feedbackDescription'] != null
          ? map['feedbackDescription'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) =>
      ResultModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ResultModel(id: $id, date: $date, searchedImage: $searchedImage, name: $name, location: $location, description: $description, web: $web, twitter: $twitter, image: $image, isSaved: $isSaved, similarity: $similarity, feedbackDescription: $feedbackDescription)';
  }

  @override
  bool operator ==(covariant ResultModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.date == date &&
        other.searchedImage == searchedImage &&
        other.name == name &&
        other.location == location &&
        other.description == description &&
        other.web == web &&
        other.twitter == twitter &&
        other.image == image &&
        other.isSaved == isSaved &&
        other.similarity == similarity &&
        other.feedbackDescription == feedbackDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        searchedImage.hashCode ^
        name.hashCode ^
        location.hashCode ^
        description.hashCode ^
        web.hashCode ^
        twitter.hashCode ^
        image.hashCode ^
        isSaved.hashCode ^
        similarity.hashCode ^
        feedbackDescription.hashCode;
  }
}
