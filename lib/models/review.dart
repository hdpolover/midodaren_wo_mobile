import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String? reviewId;
  final String? userId;
  final String? packageId;
  final String? star;
  final String? desc;
  final String? date;

  ReviewModel({
    this.userId,
    this.reviewId,
    this.packageId,
    this.star,
    this.desc,
    this.date,
  });

  factory ReviewModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return ReviewModel(
      userId: data?['userId'],
      packageId: data?['packageId'],
      star: data?['star'].toString(),
      desc: data?['desc'],
      date: data?['date'],
      reviewId: data?['reviewId'],
    );
  }
}
