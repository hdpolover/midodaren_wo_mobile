import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_preview_widget.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/package_widget.dart';

import '../resources/color_manager.dart';

class OrderPackage extends StatefulWidget {
  Package package;
  OrderPackage({required this.package, Key? key}) : super(key: key);

  @override
  State<OrderPackage> createState() => _OrderPackageState();
}

class _OrderPackageState extends State<OrderPackage> {
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    descController.dispose();
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    dateController.dispose();
    noteController.dispose();
    super.dispose();
  }

  var db = FirebaseFirestore.instance;

  PlatformFile? pickedFile;

  UploadTask? uploadTask;

  bool isLoading = false;

  String? url;

  Future selectFile(int imageNum) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile(String packageId, PlatformFile platformFile) async {
    final path = 'orders/$packageId/${platformFile.name}';
    final file = File(platformFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    String a = await snapshot.ref.getDownloadURL();

    setState(() {
      url = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text("Pesan paket"),
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
              PackagePreviewWidget(package: widget.package),
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
                "Tanggal Acara",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                controller: dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Pilih tanggal acara',
                ),
                onTap: () async {
                  var date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  dateController.text = date.toString().substring(0, 10);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Nama Lengkap",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan nama lengkap',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Nomor Telepon (WhatsApp)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan nomor telepon',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Alamat",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: addressController,
                minLines: 3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan alamat',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Catatan",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: noteController,
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan catatan (opsional)',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Upload Bukti Bayar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showGeneralDialog(
                        barrierLabel: "Barrier",
                        barrierDismissible: false,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: const Duration(milliseconds: 100),
                        context: context,
                        pageBuilder: (_, __, ___) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(
                                  top: 150, left: 32, right: 32),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SizedBox.expand(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        "Informasi Pembayaran",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Blablabla",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    const SizedBox(height: 30),
                                    Center(
                                      child: SizedBox(
                                        width: 213,
                                        height: 55,
                                        child: OutlinedButton(
                                          child: const Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              backgroundColor:
                                                  ColorManager.primary),
                                          onPressed: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .pop();
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.info,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectFile(1);
                      },
                      child: Container(
                        height: _height * 0.5,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: pickedFile != null
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(10),
                        child: pickedFile != null
                            ? Image.file(
                                File(pickedFile!.path!),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("Upload Bukti Bayar"),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.primary, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Pesan'),
                  onPressed: () {
                    _savePackageOrder();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _savePackageOrder() async {
    // if (nameController.text.isNotEmpty &&
    //     descController.text.isNotEmpty &&
    //     dateController.text.isNotEmpty &&
    //     addressController.text.isNotEmpty &&
    //     phoneController.text.isNotEmpty) {
    setState(() {
      isLoading = true;
    });

    final packageOrder = db.collection("orders").doc();

    if (pickedFile != null) {
      await uploadFile(packageOrder.id, pickedFile!);
    }

    String tdata = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

    if (url != null) {
      final data = <String, dynamic>{
        'id': packageOrder.id,
        "packageId": widget.package.id,
        "fullName": nameController.text,
        "phoneNumber": phoneController.text,
        "address": addressController.text,
        "note": noteController.text,
        "paymentProof": url,
        "date": dateController.text,
        "orderDate": tdata,
        "status": "menunggu konfirmasi",
        "catatanTolak": "-"
      };

      packageOrder.set(data);
    }

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text("Pesanan berhasil dibuat. Silakan tunggu konfirmasi admin.")));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Harap isi data pesanan.")));
    // }
  }
}
