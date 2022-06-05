import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';
import 'package:midodaren_wo_mobile/presentation/service_details.dart';
import 'package:midodaren_wo_mobile/presentation/service_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PackageWidget extends StatelessWidget {
  Package package;
  PackageWidget({required this.package, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: ServiceDetails(
            package: package,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Card(
        elevation: 1.0,
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
              child: Ink.image(
                image: NetworkImage(package.imageUrl1!),
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
                    package.title!,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "Rp. ${NumberFormat("###.0#", "en_US").format(package.price!)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
