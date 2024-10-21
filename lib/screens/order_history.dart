import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roadster/components/models/order_data.dart';
import 'package:roadster/components/cards/order_card.dart';
import 'package:roadster/components/other_widgets/loader.dart';
import 'package:roadster/screens/order_details.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _StateOrderHistory();
}

class _StateOrderHistory extends State<OrderHistory> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<OrderData>> getOrderDetails() {
    return FirebaseFirestore.instance
        .collection(userId)
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              Map<String, dynamic> order = e.data();

              return OrderData(
                  address: order["address"].toString(),
                  name: order["name"].toString(),
                  amount: order["amount"].toString(),
                  city: order["city"].toString(),
                  emailId: order["emailId"].toString(),
                  items: order["items"],
                  mobileNo: order["mobileNo"].toString(),
                  pinCode: order["pinCode"].toString(),
                  state: order["state"].toString(),
                  date: order["date"].toString(),
                  orderId: order["orderId"].toString());
            }).toList());
  }

  @override
  void initState() {
    super.initState();
  }

  static List<OrderData?> allOrders = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh_outlined))
          ],
          title: Text(
            'Your Orders',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontSize: 18),
          )),
      body: StreamBuilder<List<OrderData?>>(
          stream: getOrderDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              allOrders = snapshot.data!;
              print('successful');

              return SingleChildScrollView(
                  child: Column(
                children: List.generate(
                    allOrders.length,
                    (index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OrderDetails(orderData: allOrders[index]!),
                          ));
                        },
                        child: OrderCard(orderData: allOrders[index]!))),
              ));
            } else if (snapshot.hasError) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Unable to load data !',
                  ),
                  Text(
                    'Tap on refresh to load data, again...',
                  ),
                ],
              );
            }
            return const Loader();
          }),
    );
  }

  List<Widget> buildOrder() {
    List<Widget> cards = [];

    return cards;
  }
} /*
Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  getOrderDetails();
                },
                icon: const Icon(Icons.refresh))
          ],
          title: Text('Your Orders ',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.white, fontSize: 18)),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.black),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: buildOrder(),
      )


    )
*/
