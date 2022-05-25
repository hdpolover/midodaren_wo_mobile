import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

class Search extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const Search(
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
        toolbarHeight: MediaQuery.of(context).size.height * 0.12,
        backgroundColor: ColorManager.primary,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white54),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Cari di Midodaren',
                              contentPadding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              labelStyle:
                                  Theme.of(context).textTheme.bodyText2),
                        ),
                      ),
                      const Icon(Icons.search)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildCard(context),
          _buildCard(context),
          _buildCard(context),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ],
      ),
    );
  }

  _buildCard(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: Ink.image(
              image: const NetworkImage(
                  'https://source.unsplash.com/random/800x600?house'),
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
                  "Paket Wedding A",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 10),
                const Text("Rp. 8.000.000"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
