import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/components/my_cart_tile.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/delivery_progress_page.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:food_delivery_app/pages/payment_page.dart'; // Make sure to import this!
import 'package:food_delivery_app/services/noti_service/noti_service.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restauarant>(builder: (context, restaurant, child) {
      final userCart = restaurant.cart;
      double totalPrice = userCart.fold(0, (sum, cartItem) => sum + cartItem.totalPrice);

      return Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure You want to clear the Cart?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          restaurant.clearCart();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).colorScheme.inversePrimary),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: userCart.isEmpty
                  ? const Center(
                      child: Text(
                        "Cart is empty..",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userCart.length,
                      itemBuilder: (context, index) {
                        final cartItem = userCart[index];
                        return MyCartTile(cartItem: cartItem);
                      },
                    ),
            ),
            if (totalPrice > 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Total Price : Rs ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            MyButton(
              onTap: () {
                if (userCart.isEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text("Notice"),
                        content: Text("First order something."),
                        actions: [],
                      );
                    },
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  });
                } else {
                  _showPaymentDialog(context, totalPrice, restaurant.deliveryAddress);
                }
              },
              text: "Go to checkout",
            ),
            const SizedBox(height: 25),
          ],
        ),
      );
    });
  }

  void _showPaymentDialog(BuildContext context, double totalPrice, String deliveryAddress) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context).copyWith(
          dialogTheme: const DialogTheme(
            backgroundColor: Color.fromARGB(255, 233, 174, 91),
          ),
        ),
        child: AlertDialog(
          title: const Text("Select Payment Method", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text("Cash on Delivery", style: TextStyle(color: Colors.white)),
                leading: const Icon(Icons.money, color: Colors.black),
                onTap: () {
                  Navigator.pop(context);
                  showLottieAnimation(context, "Cash on Delivery");
                },
              ),
              ListTile(
                title: const Text("Payment Gateway", style: TextStyle(color: Colors.white)),
                leading: const Icon(Icons.credit_card, color: Colors.black),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startPayment(double amount, String deliveryAddress) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userContact = prefs.getString('contact') ?? "9904225520";
      String userEmail = prefs.getString('email') ?? "kashishdarji25@example.com";

      var options = {
        'key': 'rzp_test_3D36gu8FFcIbQp',
        'amount': (amount * 100).toInt(),
        'name': 'Zaika',
        'description': 'Food Order Payment',
        'timeout': 120,
        'prefill': {
          'contact': userContact,
          'email': userEmail,
        },
        'notes': {
          'Delivery Address': deliveryAddress,
        }
      };

      razorpay.open(options);
    } catch (e) {
      // Fluttertoast.showToast(msg: "Payment failed: ${e.toString()}");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Fluttertoast.showToast(msg: "Payment Success: ${response.paymentId}");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DeliveryProgressPage(paymentMethod: "RazorPay"),
      ),
    );
    NotiService().showNotification(title: "Zaika", body: "Your Order has been Placed!");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  void showLottieAnimation(BuildContext context, String paymentMethod) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/deli.json',
              width: 400,
              height: 400,
              repeat: false,
              animate: true,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryProgressPage(paymentMethod: paymentMethod),
                    ),
                  );
                  NotiService().showNotification(title: "Zaika", body: "Your Order has been Placed!");
                });
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Processing your payment...",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    try {
      razorpay.clear();
    } catch (e) {
      if (kDebugMode) print("Error clearing Razorpay: $e");
    }
    super.dispose();
  }
}