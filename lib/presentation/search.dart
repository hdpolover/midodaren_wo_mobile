import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_widget.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

import '../models/package.dart';

class Search extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  AppUser user;
  Search(
      {Key? key,
      required this.user,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Stream<QuerySnapshot>? _packageStream =
      FirebaseFirestore.instance.collection('packages').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: ColorManager.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white54),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Cari di Midodaren',
                              contentPadding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              labelStyle:
                                  Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                      const Icon(Icons.search)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _packageStream,
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
            return ListView(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 70),
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Package package = Package.fromFirestore(
                        document as DocumentSnapshot<Map<String, dynamic>>);

                    return PackageWidget(
                        role: widget.user.role!, package: package);
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
      ),
    );
  }

  _buildCard(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: Ink.image(
              image: const NetworkImage(
                  'https://source.unsplash.com/random/800x600?house'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Paket Wedding A",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 10),
                const Text("Rp. 8.000.000"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
