import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({super.key, required this.text, required this.onPressed});
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
            splashFactory: InkSplash.splashFactory,
            visualDensity: VisualDensity.compact,
            overlayColor: WidgetStatePropertyAll(Colors.white)),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
        ));
  }
}
