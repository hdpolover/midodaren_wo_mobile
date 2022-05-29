import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class ServicePage extends StatefulWidget {
  String? name;
  ServicePage({this.name, Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(widget.name!),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(),
    );
  }
}
