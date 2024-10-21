import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:roadster/components/buttons/small_button.dart';
import 'package:roadster/components/other_widgets/grid.dart';
import 'package:roadster/components/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:roadster/components/other_widgets/loader.dart';
import 'package:roadster/utils/app_state.dart';

List<Product> allProducts = [];

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  static Future<void> getData() async {
    dynamic serverData;
    final response =
        await http.get(Uri.parse("https://fakestoreapi.com/products"));

    serverData = jsonDecode(response.body);
    if (allProducts.length <= 20) {
      for (int i = 0; i < serverData.length; i++) {
        if (allProducts.length < 20) {
          allProducts.add($ProductFromJson(serverData[i]));
        }
      }
      AppState.counter = List.filled(serverData.length, 0);

      print(allProducts.length);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Loader(),

            ],
          );
        } else if (allProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ERROR LOADING !',
                    style: Theme.of(context).textTheme.headlineSmall),
                SmallButton(
                    text: 'Refresh',
                    onPressed: () {
                      setState(() {});
                    })
              ],
            ),
          );
        } else {
          return Grid(
            allProducts: allProducts,
          );
        }
      },
    );
  }
}
