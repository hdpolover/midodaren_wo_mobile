import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/review.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/review_widget.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

class Ulasan extends StatefulWidget {
  Ulasan({Key? key}) : super(key: key);

  @override
  State<Ulasan> createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          title: const Text("Ulasan"),
          centerTitle: true,
          elevation: 1,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: getUlasan(),
        ));
  }

  final Stream<QuerySnapshot>? _reviewStream =
      FirebaseFirestore.instance.collection('reviews').snapshots();

  getUlasan() {
    return StreamBuilder<QuerySnapshot>(
      stream: _reviewStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Terjadi kesalahan.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: ColorManager.primary,
                ),
                const SizedBox(height: 20),
                const Text("Loading"),
              ],
            ),
          );
        }

        if (snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  ReviewModel rev = ReviewModel.fromFirestore(
                      document as DocumentSnapshot<Map<String, dynamic>>);

                  return ReviewWidget(review: rev);
                })
                .toList()
                .cast(),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                const SizedBox(height: 20),
                const Text("Tidak ada layanan ditemukan."),
              ],
            ),
          );
        }
      },
    );
  }
}

class Review {}
