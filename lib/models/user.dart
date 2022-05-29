import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? userId;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? photo;

  AppUser({
    this.userId,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.photo,
  });

  factory AppUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AppUser(
      userId: data?['userId'],
      fullName: data?['fullName'],
      email: data?['email'],
      password: data?['password'],
      phoneNumber: data?['phoneNumber'],
      photo: data?['photo'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (userId != null) "userId": userId,
      if (fullName != null) "fullName": fullName,
      if (email != null) "email": email,
      if (password != null) "password": password,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (photo != null) "photo": photo,
    };
  }
}
