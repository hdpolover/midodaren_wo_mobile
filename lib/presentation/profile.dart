import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/edit_profile.dart';
import 'package:midodaren_wo_mobile/presentation/login.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';
import 'package:midodaren_wo_mobile/shared_methods.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final BuildContext menuScreenContext;
  AppUser? currentUser;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;

  Profile(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      required this.currentUser,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: MediaQuery.of(context).size.height * 0.165,
        backgroundColor: ColorManager.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
                    ),
                    const SizedBox(width: 22),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.currentUser?.fullName ?? "Nama Lengkap",
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.currentUser?.email ?? "Email",
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.headline6?.copyWith(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          ListTile(
            onTap: () {
              pushNewScreen(
                context,
                screen: EditProfile(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profil"),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ));
            },
            leading: const Icon(Icons.rate_review),
            title: const Text("Ulasan"),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
// Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PersonalInformationWidget(
              //         widget.currentCustomer),
              //   ),
              // );
            },
            leading: const Icon(Icons.help_center),
            title: const Text("Pusat Bantuan"),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              pushNewScreen(
                context,
                screen: Login(),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
            },
            leading: const Icon(Icons.logout),
            title: const Text("Keluar"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Text(
            "Midodaren WO",
          ),
          Text("Versi 1.0.0"),
        ],
      ),
    );
  }
}
