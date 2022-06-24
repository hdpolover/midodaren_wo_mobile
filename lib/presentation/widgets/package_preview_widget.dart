import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:midodaren_wo_mobile/models/package.dart';

class PackagePreviewWidget extends StatelessWidget {
  Package package;
  PackagePreviewWidget({required this.package, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Column(
        children: [
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
                const SizedBox(height: 5),
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
    );
  }
}
