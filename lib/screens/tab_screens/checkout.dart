import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:roadster/components/buttons/button.dart';
import 'package:roadster/components/buttons/small_button.dart';
import 'package:roadster/components/other_widgets/order_form.dart';
import 'package:roadster/components/other_widgets/total_amount.dart';
import 'package:roadster/screens/login_screens/login.dart';
import 'package:roadster/utils/app_state.dart';
import 'package:roadster/utils/custom_theme.dart';
import 'package:roadster/components/cards/list_card.dart';
import 'package:roadster/utils/all_providers.dart';
import 'package:badges/badges.dart' as badge;

class CheckOut extends ConsumerStatefulWidget {
  const CheckOut({super.key});

  @override
  ConsumerState<CheckOut> createState() => CheckOutConsumerState();
}

class CheckOutConsumerState extends ConsumerState<CheckOut>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  static final razorpay = Razorpay();

  bool paymentSucceed = false;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    AppState.createOrder();
    for (var i in AppState.cartProducts) {
      ref.read(counterProvider.notifier).resetCount(i);
    }
    ref.read(cartProvider.notifier).resetCart();

    setState(() {
      paymentSucceed = true;
    });

    const warning = SnackBar(
        backgroundColor: Colors.black,
        duration:  Duration(seconds: 2),
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
                      'Payment Successful !',
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

    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        paymentSucceed = false;
      });
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    const  warning = SnackBar(
        backgroundColor: Colors.black,
        duration:  Duration(seconds: 2),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:  [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Payment Failed !',
                      style: TextStyle(
                        color: Colors.red,
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
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void reset() {
    setState(() {
      for (var i in AppState.cartProducts) {
        ref.read(counterProvider.notifier).resetCount(i);
      }
      ref.read(cartProvider.notifier).resetCart();

      paymentSucceed = false;
    });
  }

  dynamic show() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.black.withOpacity(.95),
        barrierColor: Colors.transparent,
        isDismissible: false,
        builder: (context) {
          return const OrderForm();
        });
  }

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppState.cartProducts = ref.watch(cartProvider).reversed.toList();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: paymentSucceed
            ? success()
            : AppState.cartProducts.isEmpty
                ? empty()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: AppState.cartProducts.length,
                            cacheExtent: 500,
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return badge.Badge(
                                position: badge.BadgePosition.topEnd(
                                    top: -12, end: 2),
                                badgeStyle: const badge.BadgeStyle(
                                  badgeColor: Colors.transparent,
                                ),
                                badgeContent: const Icon(Icons.highlight_off,
                                    color: Colors.cyan, size: 25),
                                onTap: () {
                                  ref
                                      .read(counterProvider.notifier)
                                      .resetCount(AppState.cartProducts[index]);
                                  ref
                                      .read(cartProvider.notifier)
                                      .removeCart(AppState.cartProducts[index]);
                                },
                                child: ListCard(
                                    product: AppState.cartProducts[index]),
                              );
                            }),
                        Column(
                          children: [
                            const Divider(
                              height: 2,
                              color: CustomTheme.grey,
                              thickness: 2,
                            ),
                            Container(
                              height: 85,
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 20, right: 10, left: 10),
                              padding: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.cyan,
                                        Colors.black,
                                        Colors.cyan
                                      ])),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Container(
                                    color: Colors.grey[100],
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                    child: const TotalAmount()),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Button(
                              text: 'CHECKOUT',
                              color: Colors.black,
                              splashColor: Colors.white.withOpacity(.7),
                              textColor: Colors.white,
                              onPress: () async {
                                await show();
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  success() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 10,
        ),
        Transform.scale(
          scale: 1.12,
          child:
              LottieBuilder(lottie: AssetLottie('assets/order_success.json')),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text('Thanks for shopping !',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 26)),
        ),
        Text('Your order is confirmed and ',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
        Text('saved in orders book.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SmallButton(
            text: 'Continue',
            onPressed: reset,
          ),
        )
      ],
    );
  }

  empty() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 300,
            child: Transform.scale(
              scale: 1.5,
              child: LottieBuilder(
                  lottie: AssetLottie('assets/empty_cart.json'),
                  frameRate: FrameRate.max),
            ),
          ),
          Text('Your cart is empty !',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 26)),
          Text("Let's go and order something !",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 15)),
        ],
      ),
    );
  }
}
