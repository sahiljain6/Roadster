import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roadster/utils/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roadster/components/buttons/button.dart';
import 'package:roadster/components/other_widgets/detail.dart';
import 'package:roadster/components/input_fields/profile_input.dart';
import 'package:roadster/screens/order_history.dart';
import 'package:roadster/screens/reset._password.dart';
import 'package:roadster/utils/app_state.dart';

final formKey3 = GlobalKey<FormState>();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool button = false;
  final TextEditingController _nameCon =
      TextEditingController(text: AppState.details[0]);
  final TextEditingController _mobileCon =
      TextEditingController(text: AppState.details[1]);
  final TextEditingController _addressCon =
      TextEditingController(text: AppState.details[2]);
  final TextEditingController _cityCon =
      TextEditingController(text: AppState.details[3]);
  final TextEditingController _pinCodeCon =
      TextEditingController(text: AppState.details[4]);

  void reset() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const Reset(),
    ));
  }

  save() async {
    var pref = await SharedPreferences.getInstance();
    print('sahil');
    pref.setStringList('details', [
      _nameCon.text,
      _mobileCon.text,
      _addressCon.text,
      _cityCon.text,
      _pinCodeCon.text
    ]);

    AppState.details = pref.getStringList('details')!;
    print(AppState.details);
  }

  @override
  void dispose() {
    _nameCon.dispose();
    _mobileCon.dispose();
    _addressCon.dispose();
    _cityCon.dispose();
    _pinCodeCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
          color: Colors.grey[100],
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 55,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 35,
                    ),
                    Text('User Details',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 25, right: 25),
                child: Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 1.25, horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: CustomTheme.khaki),
                    color: Colors.black87),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: button ? form() : detailCard(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                child: Button(
                  onPress: () {
                    save();
                    setState(() {
                      button = !button;
                    });
                  },
                  shadowColor: Colors.black,
                  color: Colors.white,
                  splashColor: Colors.white.withOpacity(.7),
                  textColor: Colors.black,
                  text: button ? 'SAVE CHANGES' : 'UPDATE',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: button
                    ? Button(
                        text: 'Change Password',
                        color: Colors.white,
                        shadowColor: Colors.black,
                        splashColor: Colors.white.withOpacity(.7),
                        onPress: () => reset())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Button(
                              text: 'YOUR ORDERS',
                              color: Colors.white,
                              splashColor: Colors.white.withOpacity(.7),
                              shadowColor: Colors.black,
                              onPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const OrderHistory(),
                                ));
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 5.0,
                            ),
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.5,
                            ),
                          ),
                          Button(
                              text: 'SIGN OUT',
                              color: Colors.black,
                              textColor: Colors.white,
                              shadowColor: Colors.black,
                              onPress: () {
                                AppState.signOut();
                              }),
                        ],
                      ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  detailCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Detail(title: 'Username :  ', value: AppState.details[0]),
        Detail(
            title: 'Mobile no. :  ', mobile: true, value: AppState.details[1]),
        Detail(
            title: 'Email id :  ',
            value: FirebaseAuth.instance.currentUser!.email!),
        Detail(title: 'Address  :  ', value: AppState.details[2]),
        Detail(title: 'City :  ', value: AppState.details[3]),
        Detail(title: 'PinCode :  ', value: AppState.details[4]),
      ],
    );
  }

  form() {
    return Form(
        key: formKey3,
        autovalidateMode: AutovalidateMode.always,
        child: Column(children: [
          ProfileInput(label: 'Username :  ', textCon: _nameCon),
          ProfileInput(label: 'Mobile no. :  ', textCon: _mobileCon),
          ProfileInput(label: 'Address  :  ', textCon: _addressCon),
          ProfileInput(label: 'City :  ', textCon: _cityCon),
          ProfileInput(label: 'PinCode :  ', textCon: _pinCodeCon),
        ]));
  }
}
