import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/package_order.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_preview_widget.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_widget.dart';

import '../models/package.dart';
import '../resources/color_manager.dart';

class OrderDetails extends StatefulWidget {
  PackageOrder order;
  String role;
  OrderDetails({required this.role, required this.order, Key? key})
      : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  AppUser? currentUser;

  getUserRole() {}

  buildOrder() {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("packages")
            .doc(widget.order.packageId)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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

          if (snapshot.hasData) {
            Package package = Package.fromFirestore(
                snapshot.data! as DocumentSnapshot<Map<String, dynamic>>);

            return PackagePreviewWidget(package: package);
            // return Container();
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text("Detail Pesanan"),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Paket yang dipesan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              buildOrder(),
              //PackagePreviewWidget(package: widget.package!),
              const SizedBox(height: 10),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                "Detail Pesanan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Status Pesanan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Chip(label: Text(widget.order.status!)),
              const SizedBox(height: 20),
              const Text(
                "Tanggal Pesan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.orderDate!),
              const SizedBox(height: 20),
              const Text(
                "Tanggal Acara",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.date!),
              const SizedBox(height: 20),
              const Text(
                "Nama Pemesan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.fullName!),
              const SizedBox(height: 20),
              const Text(
                "Nomor telepon (WhatsApp)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.phoneNumber!),
              const SizedBox(height: 20),
              const Text(
                "Alamat",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.address!),
              const SizedBox(height: 20),
              const Text(
                "Catatan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(widget.order.note!),
              const SizedBox(height: 20),
              const Text(
                "Bukti Pembayaran",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: FancyShimmerImage(
                  boxFit: BoxFit.cover,
                  imageUrl: widget.order.paymentProof!,
                  errorWidget: Image.network(
                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                ),
              ),
              const SizedBox(height: 20),
              widget.role == "admin"
                  ? widget.order.status == "selesai"
                      ? Container()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.order.status ==
                                  "menunggu konfirmasi") {
                                updateStatus("terkonfirmasi");
                              } else if (widget.order.status ==
                                  "terkonfirmasi") {
                                updateStatus("selesai");
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Berhasil memperbarui status pesanan.")));

                              Navigator.of(context).pop();
                            },
                            child: widget.order.status == "menunggu konfirmasi"
                                ? const Text("Konfirmasi")
                                : const Text("Selesaikan"),
                          ),
                        )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void updateStatus(String status) {
    var collection = FirebaseFirestore.instance.collection('orders');
    collection
        .doc(widget.order.id)
        .update({'status': status}) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }
}
