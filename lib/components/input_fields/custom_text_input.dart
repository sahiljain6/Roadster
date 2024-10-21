import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  const CustomTextInput(
      {super.key,
      required this.label,
      required this.icon,
      required this.placeHolder,
      required this.textCon,
      this.password = false});

  final String label;
  final String placeHolder;
  final IconData icon;
  final bool password;
  final TextEditingController textCon;

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  late bool show = widget.password;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 18, bottom: 2),
          child: Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.textCon,
          validator: (text) {
            if (!widget.password) {
              return EmailValidator.validate(text!)
                  ? null
                  : '  Enter valid email id';
            }
            return text != null && text.length < 6
                ? '  Password must be at least 6 characters'
                : null;
          },
          obscureText: show,
          enableSuggestions: !widget.password,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.white),
          autocorrect: !widget.password,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  wordSpacing: 1),
              helperStyle: const TextStyle(fontSize: 10),
              helperText: ' ',
              isDense: true,
              constraints: const BoxConstraints(maxHeight: 100, minHeight: 40),
              suffixIcon: widget.password
                  ? Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: IconButton(
                        icon: const Icon(Icons.remove_red_eye_outlined,
                            color: Colors.amber, size: 22),
                        splashRadius: 2,
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                      ),
                    )
                  : null,
              prefixIcon: Padding(
                padding: const EdgeInsetsDirectional.only(start: 20, end: 5),
                child: Icon(widget.icon, color: Colors.amber, size: 24),
              ),
              filled: true,
              fillColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 2, color: Colors.white.withOpacity(.7)),
                  borderRadius: const BorderRadius.all(Radius.circular(35))),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2.5, color: Colors.amber),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              hintText: widget.placeHolder,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.4))),
        )
      ],
    );
  }
}
