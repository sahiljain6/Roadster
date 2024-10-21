import 'package:flutter/material.dart';
import 'package:roadster/components/cards/grid_card.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/components/other_widgets/slideshow.dart';
import 'package:roadster/screens/product_details.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/utils/custom_theme.dart';

class Grid extends StatefulWidget {
  const Grid({super.key, required this.allProducts});
  final List<Product> allProducts;

  @override
  State<Grid> createState() => GridState();
}

class GridState extends State<Grid> {
  static List<String> searchTerms = [];

  List<Widget> choices = [];
  List<String> chipList = [
    "All",
    "Perfumes",
    "Men",
    "Electronics",
    "Puma",
    "Adidas",
    "Women",
    "Jewellery",
  ];
  List<Product> selectedProducts = [];

  String selectedChoice = "";

  Map<String, dynamic> filters = {
    "Men": "men's clothing",
    "Women": "women's clothing",
    "Jewellery": "jewelery",
    "Electronics": "electronics",
  };

  void press(Product product) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetails(product: product),
    ));
  }

  @override
  void initState() {
    selectedProducts = widget.allProducts;
    selectedChoice = "All";
    super.initState();
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in chipList) {
      choices.add(ChoiceChip(
        label: Text(item),
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight:
                selectedChoice == item ? FontWeight.bold : FontWeight.w100,
            color: selectedChoice == item ? Colors.white : Colors.black),
        shape: const StadiumBorder(),
        backgroundColor: Colors.white54,
        visualDensity: VisualDensity.compact,
        selectedColor: CustomTheme.khaki,
        padding: EdgeInsets.zero,
        selected: selectedChoice == item,
        onSelected: (selected) {
          setState(() {
            selectedChoice = item;
            if (item == "All") {
              selectedProducts = widget.allProducts;
              return;
            }
            selectedProducts = allProducts
                .where((element) => element.category == filters[item])
                .toList();
          });
        },
      ));
    }
    return choices;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 55,
          ),
            const Center(
            child:  SlideShow(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(children: [
              Text(
                'Sort by Category  ',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const Icon(
                Icons.sort,
                size: 28,
                color: Colors.black,
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Center(
              child: Wrap(
                spacing: 8,
                children: _buildChoiceList(),
              ),
            ),
          ),
          selectedProducts.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                      child: Text(
                    'No items available !',
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  height: ((MediaQuery.of(context).size.width / 2) *
                          (selectedProducts.length / 2) *
                          (1 / 0.7)) +
                      20,
                  child: GridView.builder(
                    itemBuilder: (context, index) => GridCard(
                      isHome: true,
                      product: selectedProducts[index],
                      index: index,
                      onPress: () {
                        press(selectedProducts[index]);
                      },
                    ),
                    cacheExtent: 4000,
                    itemCount: selectedProducts.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 1.5,
                            mainAxisSpacing: 1.5,
                            crossAxisCount: 2,
                            childAspectRatio: .7),
                  ),
                ),
          const SizedBox(
            height: 70,
          )
        ]),
      ),
    );
  }
}
