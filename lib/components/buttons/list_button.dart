import 'package:flutter/material.dart';

class ListButton extends StatelessWidget {
  const ListButton(
      {super.key,
      required this.select,
      required this.text,
      required this.onPressed});

  final bool select;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.cyan.shade500,
                Colors.pink,
              ])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Center(
                  child: Text(text,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.black)))),
        ),
      ),
    );
  }
}
