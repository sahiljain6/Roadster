import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roadster/utils/custom_theme.dart';
import 'package:roadster/utils/my_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>const MyApp(),
          ));
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: height / 2.5,
            right: width / 1.9,
            child: SizedBox(
                width: 150, height: 150, child: Image.asset('assets/logo.jpg')),
          ),
          Positioned(
            bottom: height / 2.3,
            left: width / 2.5,
            child: Text(
              'Roadster',
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
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1),
            ),
          ),
          Positioned(
            left: width / 3,
            bottom: (height / 2.75) - 10,
            child: SizedBox(
              height: 110,
              child: Row(
                children: [
                  Text(
                    'Beyond  ',
                    style: GoogleFonts.montserrat(
                        //tangerine
                        shadows: const [
                          BoxShadow(
                            color: CustomTheme.khaki,
                            blurRadius: 6,
                            spreadRadius: 2,
                          )
                        ],
                        color: CustomTheme.khaki,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1),
                  ),
                  AnimatedTextKit(animatedTexts: [
                    RotateAnimatedText(
                      'AWESOME.',
                      transitionHeight: 60,
                      duration:const  Duration(milliseconds: 1000),
                      textStyle: GoogleFonts.montserrat(
                          //tangerine
                          shadows: const [
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 6,
                                spreadRadius: 2,
                                blurStyle: BlurStyle.inner)
                          ],
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1),
                    ),
                    RotateAnimatedText('DIFFERENT.',
                        transitionHeight: 60,
                        textStyle: GoogleFonts.montserrat(
                            //tangerine
                            shadows: const [
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 6,
                                  spreadRadius: 2,
                                  blurStyle: BlurStyle.inner)
                            ],
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1),
                        duration:const Duration(milliseconds: 1000))
                  ]),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: width / 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Made in Bharat ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                      width: 22,
                      height: 15,
                      color: Colors.white,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://i.ibb.co/5vWCWH5/india-flag-logo-3522-C6780-F-seeklogo-com.png',
                        fit: BoxFit.cover,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlideTransitionAnimation extends PageRouteBuilder {
  final Widget page;

  SlideTransitionAnimation(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return SlideTransition(
                position: Tween(begin:const  Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
                    .animate(animation),
                textDirection: TextDirection.ltr,
                child: page,
              );
            });
}
