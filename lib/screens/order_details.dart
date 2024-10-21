import 'package:flutter/material.dart';
import 'package:roadster/components/cards/ordered_product_card.dart';
import 'package:roadster/components/models/order_data.dart';
import 'package:roadster/components/other_widgets/detail.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.orderData});
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: Colors.black,
          title: Text(
            'Order Details',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white, fontSize: 18),
          )),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Detail(title: 'Date :  ', value: orderData.date),
                  Detail(title: 'Name :  ', value: orderData.name),
                  Detail(
                      title: 'Mobile no. :  ',
                      mobile: true,
                      value: orderData.mobileNo),
                  Detail(title: 'Email id :  ', value: orderData.emailId),
                  Detail(title: 'Address  :  ', value: orderData.address),
                  Detail(title: 'City :  ', value: orderData.city),
                  Detail(title: 'PinCode :  ', value: orderData.pinCode),
                  Detail(
                      title: 'Amount :  ', value: '${orderData.amount}  INR'),
                  const Detail(title: 'Items :  ', value: ''),
                  Column(
                    children: orderData.items
                        .map((item) => OrderedProductCard(item: item))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
