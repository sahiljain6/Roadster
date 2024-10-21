import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/components/cards/grid_card.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/screens/product_details.dart';
import 'package:roadster/utils/all_providers.dart';
import 'package:roadster/utils/app_state.dart';

class Favourite extends ConsumerStatefulWidget {
  const Favourite({
    super.key,
  });

  @override
  ConsumerState<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends ConsumerState<Favourite>
    with AutomaticKeepAliveClientMixin {
  void press(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetails(product: product),
    ));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppState.favProducts = ref.watch(favProvider);
    if (AppState.favProducts.isEmpty) {
      return emptyFav();
    } else {
      return Column(
        children: [
          const SizedBox(
            height: 55,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 8.0, left: 16, right: 8),
            child: Row(
              children: [
                Text('Your Favourites ',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        )),
                const Icon(
                  Icons.double_arrow,
                  color: Colors.pink,
                  size: 35,
                ),
                Text(' ${AppState.favProducts.length.toString()} items',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        )),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemBuilder: (context, index) => GridCard(
                isHome: false,
                product: AppState.favProducts[index],
                index: index,
                onPress: () {
                  press(AppState.favProducts[index]);
                },
              ),
              cacheExtent: 4000,
              itemCount: AppState.favProducts.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 1.5,
                  mainAxisSpacing: 1.5,
                  crossAxisCount: 2,
                  childAspectRatio: .7),
            ),
          ),
          const SizedBox(
            height: 70,
          )
        ],
      );
    }
  }

  emptyFav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
              scale: 5,
              child: const Icon(
                Icons.cruelty_free,
                color: Colors.grey,
              )),
          const SizedBox(
            height: 40,
          ),
          Text('There are no favs here !',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  )),
        ],
      ),
    );
  }
}
