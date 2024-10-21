import 'package:flutter/material.dart';
import 'package:roadster/components/models/order_data.dart';
import 'package:roadster/utils/custom_theme.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderData});
  final OrderData orderData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: CustomTheme.khaki, width: 1.5),
      ),
      child: DefaultTextStyle(
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontWeight: FontWeight.w100, color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  const Text(
                    'Date :  ',
                  ),
                  Text(
                    orderData.date,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Order Id :  ',
                  ),
                  Text(
                    orderData.orderId,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Status :  ',
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                  Text(
                    'Delivered !',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Amount :  ',
                  ),
                  Text(
                    "INR  ${orderData.amount} ",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
