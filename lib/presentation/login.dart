import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/presentation/dashboard.dart';
import 'package:midodaren_wo_mobile/presentation/register.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.1),
              Center(
                child: Image(
                  width: MediaQuery.of(context).size.width * 0.65,
                  image: const AssetImage('assets/logo_tulisan.png'),
                ),
              ),
              SizedBox(height: _height * 0.1),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.primary, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Dashboard(
                          menuScreenContext: context,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  const Text('Belum punya akun?'),
                  TextButton(
                    child: const Text(
                      'Daftar',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Register(),
                        ),
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                  const Text("atau"),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
