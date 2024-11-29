import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  final String headline;
  final String description;
  final DateTime time;
  String? imageUrl;

  NotesModel({
    required this.description,
    required this.headline,
    required this.time,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "headline": headline,
      "imageUrl": imageUrl,
      "description": description,
      "createdAt": time.toIso8601String(),
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      description: map["description"] ?? "",
      headline: map["headline"] ?? "",
      imageUrl: map["imageUrl"] ?? "",
      time: map["createdAt"] is Timestamp
          ? (map["createdAt"] as Timestamp).toDate()
          : map["createdAt"] != null
              ? DateTime.parse(map["createdAt"])
              : DateTime.now(),
    );
  }
}
