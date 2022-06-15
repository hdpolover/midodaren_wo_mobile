import 'package:cloud_firestore/cloud_firestore.dart';

class PackageOrder {
  String? id;
  String? packageId;
  String? fullName;
  String? address;
  String? phoneNumber;
  String? date;
  String? orderDate;
  String? paymentProof;
  String? note;
  String? status;

  PackageOrder({
    this.id,
    this.packageId,
    this.fullName,
    this.address,
    this.phoneNumber,
    this.date,
    this.paymentProof,
    this.note,
    this.status,
    this.orderDate,
  });

  factory PackageOrder.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return PackageOrder(
      id: data?['id'],
      packageId: data?['packageId'],
      fullName: data?['fullName'],
      address: data?['address'],
      phoneNumber: data?['phoneNumber'],
      date: data?['date'],
      paymentProof: data?['paymentProof'],
      note: data?['note'],
      status: data?['status'],
      orderDate: data?['orderDate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (packageId != null) "packageId": packageId,
      if (fullName != null) "fullName": fullName,
      if (address != null) "address": address,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (note != null) "note": note,
      if (date != null) "date": date,
      if (status != null) "status": status,
      if (orderDate != null) "orderDate": orderDate,
      if (paymentProof != null) "paymentProof": paymentProof,
    };
  }
}
