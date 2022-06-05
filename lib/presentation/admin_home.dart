import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/service_widget.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  final BuildContext menuScreenContext;
  AppUser user;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  AdminHome(
      {Key? key,
      required this.menuScreenContext,
      required this.user,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width,
                  color: ColorManager.primary,
                ),
                Column(
                  children: [
                    const Image(
                      width: 200,
                      height: 100,
                      image: AssetImage('assets/logo_tulisan.png'),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, left: 10),
                          child: Column(
                            children: [
                              ListTile(
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  Icons.satellite,
                                  color: ColorManager.primary,
                                ),
                                title: const Text("Layanan"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/couple.png",
                                    name: "Paket Wedding",
                                  ),
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/consultant-services.png",
                                    name: "Konsultasi",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  Icons.category,
                                  color: ColorManager.primary,
                                ),
                                title: const Text("Vendor"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/museum.png",
                                    name: "Venue",
                                  ),
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/garland.png",
                                    name: "Dekorasi",
                                  ),
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/dish.png",
                                    name: "Catering",
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/makeup.png",
                                    name: "MUA",
                                  ),
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/master-of-ceremonies.png",
                                    name: "MC",
                                  ),
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/photo-camera.png",
                                    name: "Fotografer",
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ServiceWidget(
                                    user: widget.user,
                                    image: "assets/henna.png",
                                    name: "Hena",
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15, left: 10),
                          child: Column(
                            children: [
                              ListTile(
                                horizontalTitleGap: 0,
                                leading: Icon(
                                  Icons.star,
                                  color: ColorManager.primary,
                                ),
                                title: const Text("Ulasan"),
                              ),
                              Row(
                                children: [],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
