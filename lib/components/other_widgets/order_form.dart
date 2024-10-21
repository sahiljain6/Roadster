import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:roadster/components/buttons/small_button.dart';
import 'package:roadster/components/input_fields/profile_input.dart';
import 'package:roadster/screens/tab_screens/checkout.dart';
import 'package:roadster/utils/app_state.dart';
import 'package:roadster/utils/custom_theme.dart';

final formKey4 = GlobalKey<FormState>();

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  void initState() {
    AppState.getDetails();
    super.initState();
  }

  @override
  void dispose() {
    _nameCon.dispose();
    _mobileCon.dispose();
    _addressCon.dispose();
    _cityCon.dispose();
    _pinCodeCon.dispose();
    _emailCon.dispose();
    _stateCon.dispose();

    super.dispose();
  }

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
  final TextEditingController _emailCon =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  final TextEditingController _stateCon = TextEditingController();

  bool done = true;

  void payment() {
    var options = {
      'key': 'rzp_test_wTjPLqj1D3WKgd',
      'amount': AppState.totalAmount * 100, //in the smallest currency sub-unit.
      'name': 'Roadster & Co.',
      'description': 'TotalBill',
      'timeout': 120, // in seconds
      'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
    };
    try {
      CheckOutConsumerState.razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, box) => SizedBox(
              height: MediaQuery.of(context).size.height - 90,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40.0, top: 10),
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Please confirm your order details !',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: CustomTheme.khaki)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Form(
                          key: formKey4,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(children: [
                            ProfileInput(
                                label: 'Username  :  ', textCon: _nameCon),
                            ProfileInput(
                                label: 'Email-id  :  ', textCon: _emailCon),
                            ProfileInput(
                                label: 'Mobile no.  :  ', textCon: _mobileCon),
                            ProfileInput(
                                label: 'Address  :  ', textCon: _addressCon),
                            ProfileInput(label: 'City  :  ', textCon: _cityCon),
                            ProfileInput(
                                label: 'PinCode  :  ', textCon: _pinCodeCon),
                            ProfileInput(
                                label: 'State  :  ', textCon: _stateCon),
                          ])),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Amount to be paid  :  ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: CustomTheme.khaki)),
                            Text(
                                "INR  ${AppState.totalAmount.toStringAsFixed(2)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white, fontSize: 16))
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SmallButton(
                          text: 'Pay Amount !',
                          onPressed: () async {
                            if (_nameCon.text.trim() == '' ||
                                _emailCon.text.trim() == '' ||
                                _mobileCon.text.trim() == '' ||
                                _addressCon.text.trim() == '' ||
                                _cityCon.text.trim() == '' ||
                                _pinCodeCon.text.trim() == '' ||
                                _stateCon.text.trim() == '') {
                              return showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                      backgroundColor: Colors.black,
                                      shape: StadiumBorder(),
                                      title: Center(
                                          child: Text(
                                        'Wrong Info. !',
                                        style: TextStyle(color: Colors.red),
                                      ))));
                            } else {
                              AppState.orderForm['name'] = _nameCon.text.trim();
                              AppState.orderForm['emailId'] =
                                  _emailCon.text.trim();
                              AppState.orderForm['mobileNo'] =
                                  _mobileCon.text.trim();
                              AppState.orderForm['address'] =
                                  _addressCon.text.trim();
                              AppState.orderForm['city'] = _cityCon.text.trim();
                              AppState.orderForm['pinCode'] =
                                  _pinCodeCon.text.trim();
                              AppState.orderForm['state'] =
                                  _stateCon.text.trim();
                              Navigator.of(context).pop();
                              payment();
                            }
                          }),
                    )
                  ],
                ),
              ),
            ));
  }
}
