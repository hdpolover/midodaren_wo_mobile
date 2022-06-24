import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:midodaren_wo_mobile/models/review.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/review_widget.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/service_widget.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/shared_methods.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/midodaren-app-f1485.appspot.com/o/gallery%2FMNM02307%20(1).jpg?alt=media&token=a120aad4-337e-4204-92d0-ed46831ff8be',
  'https://firebasestorage.googleapis.com/v0/b/midodaren-app-f1485.appspot.com/o/gallery%2FDSC09823%20(1).jpg?alt=media&token=c2da402b-f4b1-4fdb-9987-ce6646ab62d8',
  'https://firebasestorage.googleapis.com/v0/b/midodaren-app-f1485.appspot.com/o/gallery%2FDSC06646%20(1).jpg?alt=media&token=7aba3ddc-3f07-48cd-890e-028f109b24e3',
  'https://firebasestorage.googleapis.com/v0/b/midodaren-app-f1485.appspot.com/o/gallery%2FDSC04569%20(1).jpg?alt=media&token=faa25ad5-3382-48d0-8b15-9de9e007f4f5',
];

class Home extends StatefulWidget {
  final BuildContext menuScreenContext;
  AppUser user;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  Home(
      {Key? key,
      required this.menuScreenContext,
      required this.user,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int _current = 0;
    final CarouselController _controller = CarouselController();

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            //'No. ${imgList.indexOf(item)} image',
                            "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

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
                    widget.user.role == "admin"
                        ? Container()
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                            ),
                            items: imageSliders,
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
                                  widget.user.role == "admin"
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            // CommonSharedMethods.launchWhatsapp(
                                            //     "083848889803",
                                            //     "Halo, kak Admin. Saya mau tanya tentang paket layanan.");
                                            launchWhatsApp();
                                          },
                                          child: Card(
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Image(
                                                      width: 70,
                                                      height: 70,
                                                      image: AssetImage(
                                                          "assets/consultant-services.png"),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 5, 10, 0),
                                                    child: Text(
                                                      "Konsultasi",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                              getUlasan(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    widget.user.role == "admin"
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 15, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      horizontalTitleGap: 0,
                                      leading: Icon(
                                        Icons.work,
                                        color: ColorManager.primary,
                                      ),
                                      title: const Text("Office"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Midodaren Wedding Organizer",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "0813-5723-3775",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(Icons.location_pin),
                                              SizedBox(width: 20),
                                              Expanded(
                                                child: Text(
                                                  "Perumahan Karanglo Indah Blok T-1, Kota Malang, Jawa Timur 65126",
                                                  softWrap: true,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 40,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                MapsLauncher.launchQuery(
                                                    'Midodaren Wedding Organizer, Perumahan Karanglo Indah Blok T-1, Kota Malang, Jawa Timur 65126');
                                                // launchMap(
                                                //     "Midodaren Wedding Organizer, Perumahan Karanglo Indah Blok T-1, Kota Malang, Jawa Timur 65126");
                                              },
                                              icon:
                                                  const Icon(Icons.directions),
                                              label: const Text(
                                                  "Buka di Google Maps"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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

  final Stream<QuerySnapshot>? _reviewStream =
      FirebaseFirestore.instance.collection('reviews').snapshots();

  getUlasan() {
    return StreamBuilder<QuerySnapshot>(
      stream: _reviewStream,
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
                const SizedBox(height: 20),
                const Text("Loading"),
              ],
            ),
          );
        }

        if (snapshot.data!.docs.isNotEmpty) {
          return Column(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  ReviewModel rev = ReviewModel.fromFirestore(
                      document as DocumentSnapshot<Map<String, dynamic>>);

                  return ReviewWidget(review: rev);
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
                const Text("Tidak ada layanan ditemukan."),
              ],
            ),
          );
        }
      },
    );
  }

  launchWhatsApp() async {
    await FlutterLaunch.launchWhatsapp(
        phone: "6283848889803",
        message: "Halo, kak Admin. Saya mau tanya tentang paket layanan.");
  }

  void launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    }
  }
}
