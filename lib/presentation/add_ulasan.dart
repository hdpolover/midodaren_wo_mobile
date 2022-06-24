import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../resources/color_manager.dart';

class AddUlasan extends StatefulWidget {
  String packageId;
  String userId;
  AddUlasan({required this.userId, required this.packageId, Key? key})
      : super(key: key);

  @override
  State<AddUlasan> createState() => _AddUlasanState();
}

class _AddUlasanState extends State<AddUlasan> {
  TextEditingController descController = TextEditingController();
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text("Tambah Ulasan"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(children: [
          const Text(
            "Kualitas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RatingBar(
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                  full: const Icon(Icons.star, color: Colors.orange),
                  half: const Icon(
                    Icons.star_half,
                    color: Colors.orange,
                  ),
                  empty: const Icon(
                    Icons.star_outline,
                    color: Colors.orange,
                  )),
              onRatingUpdate: (value) {
                setState(() {
                  _ratingValue = value;
                });
              }),
          const SizedBox(height: 20),
          const Text(
            "Ulasan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descController,
            minLines: 5,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukan ulasan',
            ),
          ),
          const SizedBox(height: 50),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: ColorManager.primary, // background
                onPrimary: Colors.white, // foreground
              ),
              child: const Text('Simpan ulasan'),
              onPressed: () {
                addUlasan();

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Berhasil menambahkan ulasan")));
              },
            ),
          )
        ]),
      ),
    );
  }

  addUlasan() {
    var db = FirebaseFirestore.instance;

    final package = db.collection("reviews").doc();

    String tdata = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    final data = <String, dynamic>{
      "reviewId": package.id,
      "userId": widget.userId,
      "packageId": widget.packageId,
      "star": _ratingValue,
      "desc": descController.text,
      "date": tdata,
    };

    package.set(data);
  }
}
