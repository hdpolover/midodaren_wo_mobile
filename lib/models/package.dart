import 'package:cloud_firestore/cloud_firestore.dart';

class Package {
  String? id;
  String? title;
  String? desc;
  double? price;
  String? serviceCategory;
  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;

  Package({
    this.id,
    this.title,
    this.desc,
    this.price,
    this.serviceCategory,
    this.imageUrl1,
    this.imageUrl2,
    this.imageUrl3,
  });

  factory Package.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return Package(
      id: data?['id'],
      title: data?['title'],
      desc: data?['desc'],
      price: double.parse(data?['price']),
      serviceCategory: data?['serviceCategory'],
      imageUrl1: data?['imageUrl1'],
      imageUrl2: data?['imageUrl2'],
      imageUrl3: data?['imageUrl3'],
    );
  }
}
