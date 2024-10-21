import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    this.splashColor = Colors.yellow,
    required this.onPressed,
    required this.color,
    required this.icon,
  });
  final void Function() onPressed;
  final Color color;
  final Icon icon;

  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(color),
        elevation: const WidgetStatePropertyAll(10),
        overlayColor: WidgetStatePropertyAll(splashColor),
        shape: const WidgetStatePropertyAll(CircleBorder()),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
