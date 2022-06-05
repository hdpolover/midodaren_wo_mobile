import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/service_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ServiceWidget extends StatelessWidget {
  AppUser user;

  String? image;
  String? name;

  ServiceWidget(
      {required this.user, required this.image, required this.name, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: ServicePage(
            role: user.role!,
            name: name,
          ),
          withNavBar: false, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Card(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  width: 70,
                  height: 70,
                  image: AssetImage(image!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Text(
                  name!,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
