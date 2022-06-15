import 'package:flutter/material.dart';
import 'package:midodaren_wo_mobile/models/package_order.dart';
import 'package:midodaren_wo_mobile/presentation/order_details.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class OrderWidget extends StatelessWidget {
  PackageOrder order;
  OrderWidget({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: OrderDetails(
            package: order,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Chip(
                  label: Text(order.status!),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Dipesan pada " + order.orderDate!,
              ),
              const SizedBox(height: 10),
              Text(
                "Untuk tanggal " + order.date!,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 20),
                  Text(order.fullName!),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 20),
                  Text(order.phoneNumber!),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_pin),
                  const SizedBox(width: 20),
                  Text(order.address!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
