import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/screens/login_screens/login.dart';

enum AppLoginState { loggedOut, loggedIn }

class AppState {
  static List<String> details = List.filled(6, '');
  static List<int> counter = [];
  static List<Product> cartProducts = [];
  static List<Product> favProducts = [];
  static double totalAmount = 0;
  static int totalItems = 0;

  static Map<String, dynamic> orderForm = {
    'name': '',
    'userId': '', //no
    'orderId': '', //no
    'emailId': '',
    'mobileNo': '',
    'timeStamp': '', //no
    'items': '', //no
    'amount': AppState.totalAmount, //no
    'address': "",
    'city': '',
    'pinCode': '',
    'state': ''
  };

  static void getDetails() async {
    final pref = await SharedPreferences.getInstance();
    AppState.details = pref.getStringList('details') ?? List.filled(6, '');
  }

  static void storePw(String pw) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString('pw', pw);
  }

  static Future<void> signIn(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      storePw(password);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      const warning = SnackBar(
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
                        'Signed in successfully !',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w100,
                          fontSize: 12,
                        ),
                      ))
                ],
              ),
            ],
          ));
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
      const warning = SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.amber),
                Text('Warning!')
              ],
            ),
            Text(
              'Invalid user credentials',
              style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w100,
                  fontSize: 10),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      );
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
    }
  }

  static Future<void> signUp(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    try {
      storePw(password);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      const warning = SnackBar(
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
                      'Signed up successfully !',
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
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
      final warning = SnackBar(
        content: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.amber),
                Text('Warning!')
              ],
            ),
            Text(
              e.message!,
              style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.w100,
                  fontSize: 10),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      );
      messengerKey.currentState!
        ..removeCurrentSnackBar()
        ..showSnackBar(warning);
    }
  }

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
    const warning = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.logout_outlined,
                color: Colors.red,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Signed out !',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontSize: 12,
                    ),
                  ))
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(warning);
  }

  static Future createOrder() async {
    final userId = FirebaseAuth.instance.currentUser!.uid.toString();
    final order = FirebaseFirestore.instance.collection(userId).doc();

    final orderId = order.id;

    int index;
    List<Map<String, dynamic>> items =
        List.generate(AppState.cartProducts.length, (i) {
      index = allProducts.indexOf(AppState.cartProducts[i]);
      return {
        'product': AppState.cartProducts[i].title,
        'productId': AppState.cartProducts[i].id,
        'quantity': AppState.counter[index],
        'price': AppState.counter[index] * AppState.cartProducts[i].price
      };
    });
    var date = DateTime.now();
    AppState.orderForm['date'] = '${date.day} / ${date.month} / ${date.year}';
    AppState.orderForm['items'] = items;
    AppState.orderForm['orderId'] = orderId;
    AppState.orderForm['userId'] = userId;

    await order.set(AppState.orderForm);
  }
}

class LoginData {
  static Map<String, String> signUp = {
    "heading":
        "Let's                             Go                            Roadster ! ",
    "subHeading": "Create an account to continue",
    "label": "SIGN UP",
    "footer": "Already have an account ?",
  };
  static Map<String, String> signIn = {
    "heading":
        "Welcome                      back to                           Roadster !",
    "subHeading": "Use account email and password",
    "label": "SIGN IN",
    "footer": "Create a new account ?",
  };
}
