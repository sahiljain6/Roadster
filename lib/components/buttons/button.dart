import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onPress,
      required this.text,
      this.fontSize = 18,
      required this.color,
      this.shadowColor = Colors.grey,
      this.textColor = Colors.black,
      this.splashColor = Colors.yellow});
  final void Function() onPress;
  final Color splashColor;
  final double fontSize;
  final String text;
  final Color color;
  final Color textColor;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
      ),
      child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
              splashFactory: InkRipple.splashFactory,
              overlayColor: WidgetStatePropertyAll(splashColor),
              elevation: const WidgetStatePropertyAll(5),
              shadowColor: text == 'SIGN IN' || text == 'SIGN UP'
                  ? null
                  : WidgetStatePropertyAll(shadowColor),
              backgroundColor: WidgetStatePropertyAll(color)),
          child: Text(text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize,
                  color: textColor))),
    );
  }
}
