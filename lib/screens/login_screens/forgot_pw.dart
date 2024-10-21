// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roadster/components/input_fields/custom_text_input.dart';
import 'package:roadster/components/other_widgets/loader.dart';
import 'package:roadster/components/other_widgets/login_background.dart';
import 'package:roadster/components/buttons/small_button.dart';
import 'package:roadster/screens/login_screens/login.dart';
import 'package:roadster/utils/custom_theme.dart';

class ForgotPw extends StatefulWidget {
  const ForgotPw({super.key});

  @override
  State<ForgotPw> createState() => _ForgotPwState();
}

class _ForgotPwState extends State<ForgotPw> {
  final TextEditingController emailCon2 = TextEditingController();
  final formKey2 = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCon2.dispose();
    super.dispose();
  }

  bool loading = false;
  Future forgotPw(String email) async {
    final isValid = formKey2.currentState!.validate();

    if (!isValid) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: Loader()),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      const  warning = SnackBar(
        backgroundColor: Colors.black,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:  [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Password Reset Email Sent !',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ))
              ],
            ),
          ],
        ),
      );
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (error) {
      const warning = SnackBar(
        backgroundColor: Colors.black,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Email didn't sent, Try Again !",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w100,
                        fontSize: 12,
                      ),
                    ))
              ],
            ),
          ],
        ),
      );
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          ),
        ),
        body: BackGround(
          first: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Enter your Email id to reset the password.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: CustomTheme.logInCardDecor(),
                child: Column(
                  children: [
                    Form(
                      key: formKey2,
                      child: CustomTextInput(
                          label: 'Your email address :',
                          icon: Icons.person_outline,
                          placeHolder: 'email123@gmail.com',
                          textCon: emailCon2),
                    ),
                    SmallButton(
                      text: 'Reset Password',
                      onPressed: () {
                        forgotPw(emailCon2.text.trim());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          second: const Column(),
        ));
  }
}
