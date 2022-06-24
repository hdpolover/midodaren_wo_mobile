import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';

import '../resources/color_manager.dart';

class EditProfile extends StatefulWidget {
  AppUser user;
  EditProfile({required this.user, Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = widget.user.email!;
    nameController.text = widget.user.fullName!;
    phoneController.text = widget.user.phoneNumber!;
    addressController.text = widget.user.address!;
    passwordController.text = widget.user.password!;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text("Edit Profil"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                readOnly: true,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Nama Lengkap',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Nomor telepon',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: addressController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Alamat',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_sharp),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.primary, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: const Text('Update'),
                onPressed: () {
                  final data = <String, dynamic>{
                    "fullName": nameController.text,
                    "phoneNumber": phoneController.text,
                    "password": passwordController.text,
                    "address": addressController.text,
                  };

                  update(data);

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Berhasil memperbarui profil.")));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  update(Map<String, dynamic> data) {
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(widget.user.userId)
        .update(data) // <-- Updated data
        .then((_) => print('Success'))
        .catchError((error) => print('Failed: $error'));
  }
}
