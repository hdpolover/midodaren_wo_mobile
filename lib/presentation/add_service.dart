import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class AddService extends StatefulWidget {
  String category;
  AddService({required this.category, Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  TextEditingController descController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  var db = FirebaseFirestore.instance;

  PlatformFile? pickedFile1;
  PlatformFile? pickedFile2;
  PlatformFile? pickedFile3;

  UploadTask? uploadTask;

  bool isLoading = false;

  String? url1, url2, url3;

  Future selectFile(int imageNum) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;

    setState(() {
      switch (imageNum) {
        case 1:
          pickedFile1 = result.files.first;
          break;
        case 2:
          pickedFile2 = result.files.first;
          break;
        case 3:
          pickedFile3 = result.files.first;
          break;
      }
    });
  }

  Future uploadFile(
      String packageId, PlatformFile platformFile, int num) async {
    final path = 'packages/$packageId/${platformFile.name}';
    final file = File(platformFile.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    String a = await snapshot.ref.getDownloadURL();

    setState(() {
      switch (num) {
        case 1:
          url1 = a;
          break;
        case 2:
          url2 = a;
          break;
        case 3:
          url3 = a;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text("Tambah " + widget.category),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              const Text(
                "Nama",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan nama paket',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Deskripsi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan deskripsi paket',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Harga",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Masukan harga paket',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectFile(1);
                      },
                      child: Container(
                        height: _height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: pickedFile1 != null
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(10),
                        child: pickedFile1 != null
                            ? Image.file(
                                File(pickedFile1!.path!),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image),
                                  const SizedBox(height: 5),
                                  const Text("+ gambar"),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectFile(2);
                      },
                      child: Container(
                        height: _height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: pickedFile2 != null
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(10),
                        child: pickedFile2 != null
                            ? Image.file(
                                File(pickedFile2!.path!),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image),
                                  const SizedBox(height: 5),
                                  const Text("+ gambar"),
                                ],
                              ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectFile(3);
                      },
                      child: Container(
                        height: _height * 0.2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        padding: pickedFile3 != null
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(10),
                        child: pickedFile3 != null
                            ? Image.file(
                                File(pickedFile3!.path!),
                                fit: BoxFit.cover,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image),
                                  const SizedBox(height: 5),
                                  const Text("+ gambar"),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.primary, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Simpan'),
                  onPressed: () {
                    _savePackage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _savePackage() async {
    if (nameController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        (pickedFile1 != null || pickedFile2 != null || pickedFile3 != null)) {
      setState(() {
        isLoading = true;
      });

      final package = db.collection("packages").doc();

      if (pickedFile1 != null) {
        await uploadFile(package.id, pickedFile1!, 1);
      }
      if (pickedFile2 != null) {
        await uploadFile(package.id, pickedFile2!, 2);
      }
      if (pickedFile3 != null) {
        await uploadFile(package.id, pickedFile3!, 3);
      }

      if (url1 != null && url2 == null && url3 == null) {
        final data = <String, dynamic>{
          'id': package.id,
          "title": nameController.text,
          "desc": descController.text,
          "price": priceController.text,
          "serviceCategory": widget.category,
          "imageUrl1": url1,
          "imageUrl2": "-",
          "imageUrl3": "-",
        };

        package.set(data);
      } else if (url1 != null && url2 != null && url3 == null) {
        final data = <String, dynamic>{
          'id': package.id,
          "title": nameController.text,
          "desc": descController.text,
          "price": priceController.text,
          "serviceCategory": widget.category,
          "imageUrl1": url1,
          "imageUrl2": url2,
          "imageUrl3": "-",
        };

        package.set(data);
      } else if (url1 != null && url2 != null && url3 != null) {
        final data = <String, dynamic>{
          'id': package.id,
          "title": nameController.text,
          "desc": descController.text,
          "price": priceController.text,
          "serviceCategory": widget.category,
          "imageUrl1": url1,
          "imageUrl2": url2,
          "imageUrl3": url3,
        };

        package.set(data);
      }

      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Data layanan berhasil ditambahkan. Silakan refresh halaman.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Harap isi data layanan")));
    }
  }
}
