import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  String? id;
  String? name;
  DateTime? createdAt;
  String? email;
  DateTime? modifiedAt;

  String? phoneNumber;
  String? category;
  String? age;
  String? degree;

  UserModel({
      this.id,
      this.name,
      this.createdAt,
      this.email,
      this.modifiedAt,
    this.category,
    this.phoneNumber,
    this.age,
    this.degree
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "createdAt": createdAt,
      "modifiedAt": modifiedAt,
      "category": category,
      "phoneNumber" : phoneNumber,
      'age' : age,
      'degree' : degree

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
      category: data['category'],
      phoneNumber: data["phoneNumber"],
      age: data['age'],
      degree: data['degree'],
    );
  }
}
