import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final widgets = [
    CachedNetworkImage(
      key: const Key('1'),
      fit: BoxFit.fitWidth,
      height: 235,
      width: double.infinity,
      imageUrl: "https://i.ibb.co/9nc9bqX/1697481540478.jpg",
    ),
    CachedNetworkImage(
      key: const Key('2'),
      fit: BoxFit.fitWidth,
      height: 235,
      width: double.infinity,
      imageUrl:
          "https://i.ibb.co/ZzPmsnF/Screenshot-20231016-130652-Whats-App.jpg",
    ),
  ];
  int index = 0;
  Timer? timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        index++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    index = 0;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
      child: SizedBox(
        width: double.infinity,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 235,
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: widgets[index % 2],
                  ),
                ),
                Container(
                  height: 45,
                  decoration:
                      BoxDecoration(color: Colors.black),
                  child: Center(
                      child: Text(
                    'Coming Soon !',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  )),
                )
              ],
            )),
      ),
    );
  }
}
/*Container(
                height: 225,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                             AnimatedSwitcher(
      duration: const Duration(seconds: 1),
      child: widgets[index%3],
    ),
                        Container(
                          width: double.infinity,
                          height: 40,
                          decoration:
                              BoxDecoration(color: Colors.black.withOpacity(.65)),
                          child: Center(
                              child: Text(
                            'Coming Soon !',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                          )),
                        )
                      ],
                    )))*/
