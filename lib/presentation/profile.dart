import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

class Profile extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const Profile(
      {Key? key,
      required this.menuScreenContext,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

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
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(width: 22),
                    Text(
                      "Nama user",
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Colors.white,
                          ),
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
          SizedBox(height: 10),
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
            leading: const Icon(Icons.edit),
            title: const Text("Edit Profil"),
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
// Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PersonalInformationWidget(
              //         widget.currentCustomer),
              //   ),
              // );
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
