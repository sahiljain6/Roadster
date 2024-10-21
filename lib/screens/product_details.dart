import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/components/buttons/circular_button.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/utils/app_state.dart';
import 'package:roadster/components/buttons/button.dart';
import 'package:roadster/utils/all_providers.dart';

class ProductDetails extends ConsumerStatefulWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  int index = 0;
  bool cart = false;
  @override
  void initState() {
    index = allProducts.indexOf(widget.product);
    cart = AppState.cartProducts.contains(widget.product);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState.counter = ref.read(counterProvider);
    AppState.favProducts = ref.watch(favProvider);

    bool fav = AppState.favProducts.contains(widget.product);

    if (AppState.counter[index] == 0) {
      cart = false;
    }
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {


        return Navigator.of(context).pop(AppState.counter[index]);

      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          body: DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineSmall!,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  return Navigator.of(context)
                                      .pop(AppState.counter[index]);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,weight:25 ,
                                  size: 32,
                                )),
                            IconButton(
                              onPressed: () {
                                SnackBar snackBar;
                                if (fav) {
                                  ref
                                      .read(favProvider.notifier)
                                      .removeFav(widget.product);
                                  snackBar = const SnackBar(
                                      backgroundColor: Colors.black,
                                      duration: Duration(seconds: 2),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.heart_broken_rounded,
                                                color: Colors.pink,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: Text(
                                                    'Removed from Favourites !',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 12,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ));

                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                } else {
                                  ref
                                      .read(favProvider.notifier)
                                      .addFav(widget.product);
                                  snackBar = const SnackBar(
                                      backgroundColor: Colors.black,
                                      duration: Duration(seconds: 2),
                                      content: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.pink,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8),
                                                  child: Text(
                                                    'Added to Favourites !',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      fontSize: 12,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ],
                                      ));

                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }
                              },
                              color: Colors.white,
                              splashColor: Colors.pink.shade100,
                              icon: Icon(
                                Icons.favorite,
                                color: fav ? Colors.pink : Colors.grey,
                                size: 28,
                              ),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: FittedBox(
                        child: Hero(
                          tag: widget.product.imageUrl,
                          child: CachedNetworkImage(
                            imageUrl: widget.product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text('Title : '),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: 280,
                                    child: Text(
                                      widget.product.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text('Price : '),
                                ),
                                const Icon(
                                  Icons.currency_rupee,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    widget.product.price.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text('Rating : '),
                                ),
                                FittedBox(
                                  child: RatingBar.builder(
                                      glow: true,
                                      glowColor: Colors.yellow,
                                      ignoreGestures: true,
                                      minRating: 1,
                                      initialRating: widget.product.rating,
                                      itemSize: 20,
                                      allowHalfRating: true,
                                      itemBuilder: (context, index) =>
                                          const Icon(Icons.star,
                                              color: Colors.amber),
                                      onRatingUpdate: (value) {},
                                      itemCount: 5),
                                ),
                                Text(
                                  '     ${widget.product.rating.toStringAsFixed(1)} / 5',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text('Quantity : '),
                                const SizedBox(
                                  width: 20,
                                ),
                                CircularButton(
                                    color: Colors.black,
                                    splashColor: Colors.white.withOpacity(.7),
                                    onPressed: () {
                                      if (AppState.counter[index] == 1) {
                                        ref
                                            .read(counterProvider.notifier)
                                            .resetCount(widget.product);
                                        ref
                                            .read(cartProvider.notifier)
                                            .removeCart(widget.product);

                                        setState(() {});
                                      } else if (AppState.counter[index] > 0) {
                                        ref
                                            .read(counterProvider.notifier)
                                            .subCount(widget.product);
                                        setState(() {});
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 23,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                          AppState.counter[index].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w800)),
                                    ),
                                  ),
                                ),
                                CircularButton(
                                    color: Colors.black,
                                    splashColor: Colors.white.withOpacity(.7),
                                    onPressed: () {
                                      ref
                                          .read(counterProvider.notifier)
                                          .addCount(widget.product);
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 23,
                                    )),
                              ],
                            ),
                          ),
                          Button(
                            textColor: Colors.white,
                            fontSize: 16,
                            color: Colors.black,
                            splashColor: Colors.white.withOpacity(.7),
                            text: cart ? 'Remove from Cart' : 'Add to Cart',
                            onPress: () {
                              if (AppState.counter[index] > 0) {
                                if (!cart) {
                                  ref
                                      .read(cartProvider.notifier)
                                      .addCart(widget.product);
                                  setState(() {
                                    cart = true;
                                  });
                                } else {
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeCart(widget.product);
                                  ref
                                      .read(counterProvider.notifier)
                                      .resetCount(widget.product);
                                  setState(() {
                                    cart = false;
                                  });
                                }
                              }
                            },
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 8),
                              child: Text(
                                'About the item :',
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(widget.product.description,
                                style: Theme.of(context).textTheme.bodySmall),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
