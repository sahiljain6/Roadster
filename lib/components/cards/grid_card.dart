import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/utils/all_providers.dart';
import 'package:roadster/utils/app_state.dart';
import 'package:roadster/utils/custom_theme.dart';

class GridCard extends ConsumerWidget {
  const GridCard({
    super.key,
    required this.product,
    required this.index,
    required this.onPress,
    required this.isHome,
  });
  final void Function() onPress;
  final int index;
  final Product product;
  final bool isHome;

  @override
  Widget build(BuildContext context, ref) {
    AppState.favProducts = ref.watch(favProvider);
    bool fav = AppState.favProducts.contains(product);
    return Container(
      padding: const EdgeInsets.only(bottom: 1),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: CustomTheme.cardShadow,
          ),
      margin: index % 2 == 0
          ? const EdgeInsets.only(
              left: 3,
            )
          : const EdgeInsets.only(
              right: 3,
            ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onPress,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Hero(
                          tag: isHome ? product.imageUrl : index.toString(),
                          child: CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              fit: BoxFit.contain),
                        )),
                    Expanded(

                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                bottom: 2,
                              ),
                              child: SizedBox(
                                width: 300,
                                child: Text(product.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 3,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.currency_rupee,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    product.price.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 20),
                                Text(
                                  product.rating.toStringAsFixed(1),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                  onTap: () {
                    if (fav) {
                      ref.read(favProvider.notifier).removeFav(product);
                    } else {
                      ref.read(favProvider.notifier).addFav(product);
                    }
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 22,
                    color: fav ? Colors.pink : Colors.grey,
                  ))),
        ],
      ),
    );
  }
}
