import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roadster/components/other_widgets/loader.dart';
import 'package:roadster/components/other_widgets/login_background.dart';
import 'package:roadster/components/buttons/small_button.dart';
import 'package:roadster/screens/login_screens/login.dart';
import 'package:roadster/utils/custom_theme.dart';
import 'package:roadster/utils/my_app.dart';


class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isVerified = false;
  bool resend = false;
  int sec = 59;
  Timer? timer;
  Future sendEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      const warning =  SnackBar(
        backgroundColor: Colors.black,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Verify email sent",
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
      Timer? time;
      time = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (sec == 0) {
          time?.cancel();
          setState(() {
            resend = true;
            sec = 59;
          });
          return;
        }
        setState(() {
          resend = false;
          sec--;
        });
      });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      const warning =  SnackBar(
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
                      "Can't send Verify Email",
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
    }
  }

  Future checkVerify() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isVerified) {
      timer?.cancel();
    }
  }

  @override
  void initState() {
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isVerified) {
      sendEmail();
      timer =
          Timer.periodic(const Duration(seconds: 3), (timer) => checkVerify());
    }

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isVerified
        ? const MyApp()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            body: BackGround(
                first: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 20, left: 3, right: 3),
                      decoration: CustomTheme.logInCardDecor(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 15, left: 15, right: 15),
                            child: Text(
                              'A verification email has been sent to your email address.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'You can request another email after:',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text('$sec seconds',
                              style: const TextStyle(color: Colors.orange)),
                          resend
                              ? SmallButton(
                                  text: 'Resent Email',
                                  onPressed: () {
                                    sendEmail();
                                  },
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Loader(),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                second: const Column()),
          );
  }
}
