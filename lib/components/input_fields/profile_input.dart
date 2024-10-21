import 'package:flutter/material.dart';
import 'package:roadster/utils/custom_theme.dart';

class ProfileInput extends StatefulWidget {
  const ProfileInput({
    super.key,
    required this.label,
    required this.textCon,
  });

  final String label;

  final TextEditingController textCon;

  @override
  State<ProfileInput> createState() => _ProfileInputState();
}

class _ProfileInputState extends State<ProfileInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Row(
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: CustomTheme.khaki,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.textCon,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              maxLines: widget.label == 'Address  :  ' ? 10 : 1,
              cursorWidth: 1,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                prefixText: widget.label == 'Mobile no. :  ' ? '+91-' : null,
                prefixStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: CustomTheme.khaki,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                isDense: true,
                constraints:
                    const BoxConstraints(maxHeight: 100, minHeight: 40),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.white.withOpacity(0.3)),
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.cyan.withOpacity(.6)),
                    borderRadius: const BorderRadius.all(Radius.circular(35))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
