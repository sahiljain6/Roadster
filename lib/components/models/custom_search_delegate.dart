import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/screens/product_details.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    "men's aesthetics",
    "women's aesthetics",
    " latest electronics gadgets",
    "ethnic wear",
    "branded clothes",
    "diwali specials"
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for (var i in allProducts) {
      if (i.title.toLowerCase().contains(query.trim().toLowerCase())) {
        matchQuery.add(i.title);
      }
    }
    if (matchQuery.isEmpty) {
      for (var i in allProducts) {
        if (i.category.toLowerCase().contains(query.toLowerCase().trim())) {
          matchQuery.add(i.title);
        }
      }
    }

    return matchQuery.isEmpty
        ? Center(
            child: Text(
            'No Results Found !',
            style: Theme.of(context).textTheme.headlineSmall,
          ))
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              int i =
                  allProducts.indexWhere((element) => element.title == result);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetails(product: allProducts[i]),
                      ));
                    },
                    title: Text(result,
                        style: Theme.of(context).textTheme.bodySmall),
                    contentPadding: EdgeInsets.zero,
                    leading: Hero(
                      tag: allProducts[i].imageUrl,
                      transitionOnUserGestures: true,
                      child: CachedNetworkImage(
                        imageUrl: allProducts[i].imageUrl,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var i in searchTerms) {
      if (i.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(i);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
          },
        );
      },
    );
  }
}
