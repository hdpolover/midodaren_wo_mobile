import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';
import 'package:midodaren_wo_mobile/presentation/order_package.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/shared_methods.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../resources/color_manager.dart';

class ServiceDetails extends StatefulWidget {
  Package package;
  ServiceDetails({required this.package, Key? key}) : super(key: key);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<Widget> getImages() {
    List<Widget> images = [];
    if (widget.package.imageUrl2 != "-") {
      images = [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl1!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl2!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
      ];
    } else if (widget.package.imageUrl3 != "-") {
      images = [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl1!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl2!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl3!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
      ];
    } else {
      images = [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: FancyShimmerImage(
            boxFit: BoxFit.cover,
            imageUrl: widget.package.imageUrl1!,
            errorWidget: Image.network(
                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
          ),
        ),
      ];
    }

    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: Text(widget.package.title!),
        centerTitle: true,
        elevation: 1,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ImageSlideshow(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  initialPage: 0,
                  indicatorColor: ColorManager.primary,
                  indicatorBackgroundColor: Colors.grey,
                  // onPageChanged: (value) {
                  //   debugPrint('Page changed: $value');
                  // },
                  // autoPlayInterval: 3000,
                  // isLoop: true,
                  children: getImages(),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.package.title!,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                          "Rp. ${NumberFormat("###.0#", "en_US").format(widget.package.price!)}"),
                      const SizedBox(height: 10),
                      Divider(),
                      const SizedBox(height: 10),
                      Text(
                        "Deskripsi layanan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.package.desc!),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            CommonSharedMethods.launchWhatsapp("+6283848889803",
                                "Halo, kak Admin. Saya mau pesan paket ${widget.package.title}. Bisa minta infonya?");
                          },
                          icon: const Icon(Icons.chat),
                          label: const Text('Konsultasi Admin'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showGeneralDialog(
                              barrierLabel: "Barrier",
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionDuration:
                                  const Duration(milliseconds: 100),
                              context: context,
                              pageBuilder: (_, __, ___) {
                                return Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.47,
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(
                                        top: 150, left: 32, right: 32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: SizedBox.expand(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 10),
                                          const Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 60,
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Yakin untuk memesan? Cek ketersediaan paket ke Admin.",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.normal),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          Center(
                                            child: SizedBox(
                                              width: 213,
                                              height: 55,
                                              child: OutlinedButton(
                                                child: const Text(
                                                  "PESAN",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                style: OutlinedButton.styleFrom(
                                                    backgroundColor:
                                                        ColorManager.primary),
                                                onPressed: () {
                                                  Navigator.of(context).pop();

                                                  pushNewScreen(
                                                    context,
                                                    screen: OrderPackage(
                                                      package: widget.package,
                                                    ),
                                                    withNavBar:
                                                        false, // OPTIONAL VALUE. True by default.
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .fade,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Center(
                                            child: SizedBox(
                                              width: 213,
                                              height: 55,
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        width: 1.0,
                                                        color: ColorManager
                                                            .primary),
                                                    backgroundColor:
                                                        Colors.transparent),
                                                child: Text("KONSULTASI ADMIN",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        ?.copyWith(
                                                            color: ColorManager
                                                                .primary)),
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
                          child: const Text('Pesan Sekarang'),
                          style: ElevatedButton.styleFrom(
                            primary: ColorManager.primary, // background
                            onPrimary: Colors.white, // foreground
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
