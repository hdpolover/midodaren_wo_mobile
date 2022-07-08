import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/package.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/add_service.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../resources/color_manager.dart';

class ServicePage extends StatefulWidget {
  String? name;
  AppUser user;
  ServicePage({required this.user, required this.name, Key? key})
      : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  Stream<QuerySnapshot>? _packageStream;

  @override
  void initState() {
    super.initState();
    _packageStream = FirebaseFirestore.instance
        .collection('packages')
        .where("serviceCategory", isEqualTo: widget.name!)
        .where("status", isEqualTo: "aktif")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(widget.name!),
        centerTitle: true,
        elevation: 1,
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
                  SizedBox(height: 20),
                  Text("Loading"),
                ],
              ),
            );
          }

          if (snapshot.data!.docs.isNotEmpty) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Package package = Package.fromFirestore(
                        document as DocumentSnapshot<Map<String, dynamic>>);

                    return PackageWidget(user: widget.user, package: package);
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
                  Text("Tidak ada layanan ${widget.name} ditemukan."),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: widget.user.role == "admin"
          ? FloatingActionButton.extended(
              onPressed: () {
                pushNewScreen(
                  context,
                  screen: AddService(
                    category: widget.name!,
                  ),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Tambah Baru'),
              backgroundColor: ColorManager.primary,
            )
          : Container(),
    );
  }
}
