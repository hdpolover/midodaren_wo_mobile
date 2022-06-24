import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/dashboard.dart';
import 'package:midodaren_wo_mobile/presentation/register.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';
import 'package:midodaren_wo_mobile/services/auth_service.dart';
import 'package:midodaren_wo_mobile/shared_methods.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Auth _auth = Auth();
  final SharedMethods _sharedMethods = SharedMethods();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
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
                    'Masuk',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorManager.primary),
                      ),
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: ColorManager.primary,
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Masukan email'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
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
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: ColorManager.white,
                        )
                      : const Text('Login'),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      AppUser user = await _auth.loginWithEmail(
                          emailController.text, passwordController.text);

                      _sharedMethods.saveUserLoginsDetails(user);

                      setState(() {
                        isLoading = false;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Dashboard(
                            menuScreenContext: context,
                            currentUser: user,
                          ),
                        ),
                      );
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Pengguna tidak ditemukan. Coba lagi.")));
                    }
                  },
                ),
              ),
              const SizedBox(height: 50),
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
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(right: 20.0),
              //         child: const Divider(
              //           color: Colors.black,
              //           height: 36,
              //         ),
              //       ),
              //     ),
              //     const Text("atau"),
              //     Expanded(
              //       child: Container(
              //         margin: const EdgeInsets.only(left: 20.0),
              //         child: const Divider(
              //           color: Colors.black,
              //           height: 36,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
