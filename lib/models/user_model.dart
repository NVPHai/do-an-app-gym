import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final int age;
  final double weight;
  final double height;
  final String photoUrl;
  final String backgroundUrl;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.age = 0,
    this.weight = 0.0,
    this.height = 0.0,
    this.photoUrl = '',
    this.backgroundUrl = '',
    this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      weight: map['weight']?.toDouble() ?? 0.0,
      height: map['height']?.toDouble() ?? 0.0,
      photoUrl: map['photoUrl'] ?? '',
      backgroundUrl: map['backgroundUrl'] ?? '',
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'photoUrl': photoUrl,
      'backgroundUrl': backgroundUrl,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  UserModel copyWith({
    String? name,
    int? age,
    double? weight,
    double? height,
    String? photoUrl,
    String? backgroundUrl,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      name: name ?? this.name,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      photoUrl: photoUrl ?? this.photoUrl,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
      createdAt: createdAt,
    );
  }
}
