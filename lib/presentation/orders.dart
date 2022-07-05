import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/button/gf_button_bar.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/getwidget.dart';
import 'package:midodaren_wo_mobile/models/package_order.dart';
import 'package:midodaren_wo_mobile/models/user.dart';
import 'package:midodaren_wo_mobile/presentation/widgets/order_widget.dart';
import 'package:midodaren_wo_mobile/resources/color_manager.dart';

class Orders extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  AppUser user;
  Orders(
      {Key? key,
      required this.menuScreenContext,
      required this.user,
      required this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Stream<QuerySnapshot>? _orderStream;

  @override
  void initState() {
    super.initState();
    _orderStream = FirebaseFirestore.instance
        .collection('orders')
        .where("userId", isEqualTo: widget.user.userId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        title: const Text("Pesanan"),
        centerTitle: true,
        elevation: 1,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _orderStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Terjadi kesalahan.'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                  const SizedBox(height: 20),
                  const Text("Loading"),
                ],
              ),
            );
          }

          if (snapshot.data!.docs.isNotEmpty) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    PackageOrder order = PackageOrder.fromFirestore(
                        document as DocumentSnapshot<Map<String, dynamic>>);

                    return OrderWidget(
                      role: widget.user.role!,
                      order: order,
                      userId: widget.user.userId!,
                    );
                  })
                  .toList()
                  .cast(),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 20),
                  const Text("Tidak ada layanan pesanan ditemukan."),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
