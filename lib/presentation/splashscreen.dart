import 'dart:async';

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import 'login.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() async {
    _goto(Login());
  }

  _goto(Widget name) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => name,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          width: MediaQuery.of(context).size.width * 0.65,
          image: const AssetImage('assets/logo.png'),
        ),
      ),
    );
  }
}
