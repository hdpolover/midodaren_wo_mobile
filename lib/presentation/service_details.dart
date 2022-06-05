import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';

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
    if (widget.package.imageUrl3 != "-") {
      images = [
        Ink.image(
          image: NetworkImage(widget.package.imageUrl1!),
          fit: BoxFit.cover,
        ),
        Ink.image(
          image: NetworkImage(widget.package.imageUrl2!),
          fit: BoxFit.cover,
        ),
      ];
    } else {
      images = [
        Ink.image(
          image: NetworkImage(widget.package.imageUrl1!),
          fit: BoxFit.cover,
        ),
        Ink.image(
          image: NetworkImage(widget.package.imageUrl2!),
          fit: BoxFit.cover,
        ),
        Ink.image(
          image: NetworkImage(widget.package.imageUrl3!),
          fit: BoxFit.cover,
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
      body: ListView(children: [
        widget.package.imageUrl2 != "-"
            ? ImageSlideshow(
                width: double.infinity,
                height: 200,
                initialPage: 0,
                indicatorColor: ColorManager.primary,
                indicatorBackgroundColor: Colors.grey,
                onPageChanged: (value) {
                  debugPrint('Page changed: $value');
                },
                autoPlayInterval: 3000,
                isLoop: true,
                children: getImages(),
              )
            : SizedBox(
                height: 200.0,
                child: Ink.image(
                  image: NetworkImage(widget.package.imageUrl1!),
                  fit: BoxFit.cover,
                ),
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
      ]),
    );
  }
}
