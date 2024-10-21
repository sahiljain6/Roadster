import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(color:Colors.black,shape: BoxShape.circle),
          width: 60,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                  width: 60,
                  height:60,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.cyan,
                  )),
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage(
                  'assets/logo.jpg',
                ),
              )
            ],
          )),
    );
  }
}
