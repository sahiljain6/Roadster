import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/screens/product_details.dart';
import 'package:roadster/utils/all_providers.dart';
import 'package:roadster/utils/app_state.dart';

class ListCard extends ConsumerStatefulWidget {
  const ListCard({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<ListCard> createState() => _ListCardState();
}

class _ListCardState extends ConsumerState<ListCard> {


  @override
  Widget build(BuildContext context) {
    AppState.counter = ref.watch(counterProvider);
    int index = allProducts.indexOf(widget.product);
    double price =
        (widget.product.price * (AppState.counter[index].toDouble()));

    return GestureDetector(
      onTap: () async {
        int previous = AppState.counter[index];
        int? current = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetails(product: widget.product)));
        if (previous != current) {
          setState(() {});
        }
        print(' this is previous $previous and this is $current');
      },
      child: Container(
        height: 135,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 3,
                  spreadRadius: .1,
                  offset: const Offset(0, 3)),
            ]),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.product.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: SizedBox(
                            width: 300,
                            child: Text(widget.product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.currency_rupee,
                                size: 18,
                              ),
                              Text(
                                price.toStringAsFixed(2),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                           IconButton(
                                onPressed: () {
                                  if (AppState.counter[index] > 1) {
                                    ref
                                        .read(counterProvider.notifier)
                                        .subCount(widget.product);
                                    setState(() {});
                                  }
                                },
                                icon: const Icon(
                                  Icons.remove_circle,
                                  color: Colors.black,
                                )),
                            Text(AppState.counter[index].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700)),
                            IconButton(
                                onPressed: () {
                                  ref
                                      .read(counterProvider.notifier)
                                      .addCount(widget.product);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
