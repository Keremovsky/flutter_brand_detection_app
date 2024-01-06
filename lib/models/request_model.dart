// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestModel {
  final int id;
  final String? image;
  final String companyName;
  final String description;
  final String country;
  final String website;
  final String twitter;

  RequestModel({
    required this.id,
    required this.image,
    required this.companyName,
    required this.description,
    required this.country,
    required this.website,
    required this.twitter,
  });

  RequestModel copyWith({
    int? id,
    String? image,
    String? companyName,
    String? description,
    String? country,
    String? website,
    String? twitter,
  }) {
    return RequestModel(
      id: id ?? this.id,
      image: image ?? this.image,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      country: country ?? this.country,
      website: website ?? this.website,
      twitter: twitter ?? this.twitter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'companyName': companyName,
      'description': description,
      'country': country,
      'website': website,
      'twitter': twitter,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      id: map['id'] as int,
      image: map['image'] != null ? map['image'] as String : null,
      companyName: map['companyName'] as String,
      description: map['description'] as String,
      country: map['country'] as String,
      website: map['website'] as String,
      twitter: map['twitter'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestModel(id: $id, image: $image, companyName: $companyName, description: $description, country: $country, website: $website, twitter: $twitter)';
  }

  @override
  bool operator ==(covariant RequestModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.image == image &&
        other.companyName == companyName &&
        other.description == description &&
        other.country == country &&
        other.website == website &&
        other.twitter == twitter;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        companyName.hashCode ^
        description.hashCode ^
        country.hashCode ^
        website.hashCode ^
        twitter.hashCode;
  }
}
