import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/utils/app_state.dart';
import 'package:roadster/utils/all_providers.dart';

class TotalAmount extends ConsumerStatefulWidget {
  const TotalAmount({
    super.key,
  });

  @override
  ConsumerState<TotalAmount> createState() => TotalAmountState();
}

class TotalAmountState extends ConsumerState<TotalAmount> {
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppState.totalAmount = 0;
    AppState.totalItems = 0;
    var quantity = ref.read(counterProvider);
    var i = ref.read(cartProvider);

    for (var item in i) {
      AppState.totalItems += quantity[allProducts.indexOf(item)];
    }
    for (var i in AppState.cartProducts) {
      int index = allProducts.indexOf(i);
      var price = i.price * quantity[index];
      AppState.totalAmount += price;
    }
    return DefaultTextStyle(
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Total Items : ',
              ),
              const Spacer(),
              Text(
                AppState.totalItems.toString(),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Total Amount : ',
              ),
              const Spacer(),
              const Icon(
                Icons.currency_rupee,
                color: Colors.black,
              ),
              Text(
                AppState.totalAmount.toStringAsFixed(2),
              )
            ],
          ),
        ],
      ),
    );
  }
}
