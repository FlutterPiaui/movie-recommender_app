// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movie {
  final String title;
  final String streamingPlatform;
  final String image;
  final String description;
  Movie({
    required this.title,
    required this.streamingPlatform,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'streamingPlatform': streamingPlatform,
      'image': image,
      'description': description,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      title: map['title'] as String,
      streamingPlatform: map['streamingPlatform'] as String,
      image: map['image'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
