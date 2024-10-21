import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadster/components/models/custom_search_delegate.dart';
import 'package:roadster/screens/tab_screens/checkout.dart';
import 'package:roadster/screens/tab_screens/favourite.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/screens/tab_screens/profile.dart';
import 'package:roadster/utils/app_state.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  static PageController pageCon = PageController(
    initialPage: 0,keepPage: true
  );

  @override
  void initState() {
    setState(() {
      AppState.getDetails();
      print(AppState.details);
    });

    super.initState();
  }
List<Widget> screen=[Home(),CheckOut(),Favourite(),Profile()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              //billabong,Brush Script, lobster,pacifico

              backgroundColor: Colors.black,
              surfaceTintColor: Colors.black,
              elevation: 50,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              shadowColor: Colors.black12,
              title: Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                child: DefaultTextStyle(
                  style: GoogleFonts.charmonman(
                      //tangerine
                      shadows: const [
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 6,
                            spreadRadius: 2,
                            blurStyle: BlurStyle.inner)
                      ],
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                  child: const Text(
                    'Roadster',
                  ),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(
                          context: context, delegate: CustomSearchDelegate());
                    },
                    iconSize: 28,
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
            ),
            bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: DefaultTextStyle(
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                    ),
                    child: FlashyTabBar(
                      height: 50,
                      backgroundColor: Colors.black,
                      selectedIndex: selectedIndex,
                      iconSize: 26,
                      onItemSelected: (index) {
                        setState(() {
                         // pageCon.jumpToPage(index);
                          selectedIndex = index;
                          pageCon.jumpToPage(selectedIndex);
                        });
                      },
                      items: [
                        FlashyTabBarItem(
                          icon: const Icon(Icons.home),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white54,
                          title: const Text(
                            'Home',
                          ),
                        ),
                        FlashyTabBarItem(
                          icon: const Icon(Icons.shopping_cart),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white54,
                          title: const Text('Cart'),
                        ),
                        FlashyTabBarItem(
                          icon: const Icon(Icons.favorite),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white54,
                          title: const Text('Fav'),
                        ),
                        FlashyTabBarItem(
                          icon: const Icon(Icons.person),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white54,
                          title: const Text('Profile'),
                        ),
                      ],
                    ))),
          body: PageView(
            controller: pageCon,
            children: screen,allowImplicitScrolling: true,
            onPageChanged: (value) {
              setState(() {
                selectedIndex=value;
              });

            },),
            ));
  }
}
