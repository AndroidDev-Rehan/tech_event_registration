import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String? id;
  String? name;
  DateTime? createdAt;
  String? email;
  String? profileURL;
  DateTime? modifiedAt;
  String? city;
  String? genre;
  String? bio ;
  double? rating;

  UserModel({
      this.id,
      this.name,
      this.createdAt,
      this.email,
      this.profileURL,
      this.modifiedAt,
      this.city,
      this.bio,
      this.genre,
      this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "createdAt": createdAt,
      "profileURL": profileURL,
      "modifiedAt": modifiedAt,
      "city": city,
      "bio": bio,
      "genre": genre,

    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map;
    return UserModel(
      id: snapshot.id,
      name: data["name"],
      email: data["email"],
      createdAt: data["createdAt"].toDate(),
      modifiedAt: data["modifiedAt"].toDate(),
      profileURL: data["profileURL"],
      city: data["city"],
    );
  }
}
