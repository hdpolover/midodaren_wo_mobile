import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/service_details.dart';
import 'package:midodaren_wo_mobile/presentation/service_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PackageWidget extends StatelessWidget {
  Package package;
  AppUser user;
  PackageWidget({required this.user, required this.package, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: ServiceDetails(
            user: user,
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
            // SizedBox(
            //   height: 200.0,
            //   child: Ink.image(
            //     image: NetworkImage(package.imageUrl1!),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                  boxFit: BoxFit.cover,
                  imageUrl: package.imageUrl1!,
                  errorWidget: Image.network(
                      'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                ),
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
                    "Disediakan oleh ${package.company}",
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
