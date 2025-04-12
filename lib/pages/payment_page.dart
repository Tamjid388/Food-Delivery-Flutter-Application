import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:food_delivery_app/services/noti_service/noti_service.dart';
import 'package:lottie/lottie.dart';
import 'package:food_delivery_app/components/my_button.dart';
import 'package:food_delivery_app/pages/delivery_progress_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvfocused = false;

  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Payment", style: TextStyle(color: Colors.grey)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder Name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showLottieAnimation();
                NotiService().showNotification(
                  title: "Zaika",
                  body: "Your Order has been Placed!",
                );
              },
              child: const Text("Yes"),
            ),
          ],
        ),
      );
    }
  }

  void showLottieAnimation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/deli.json',
                width: 400,
                height: 400,
                repeat: false,
              ),
              const SizedBox(height: 10),
              const Text(
                "Processing your payment...",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DeliveryProgressPage(paymentMethod: 'Credit Card'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null ? const Icon(Icons.person, size: 50) : null,
                ),
              ),
              const SizedBox(height: 20),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvfocused,
                onCreditCardWidgetChange: (_) {},
              ),
              CreditCardForm(
                formKey: formKey,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                onCreditCardModelChange: (data) {
                  setState(() {
                    cardNumber = data.cardNumber;
                    expiryDate = data.expiryDate;
                    cardHolderName = data.cardHolderName;
                    cvvCode = data.cvvCode;
                    isCvvfocused = data.isCvvFocused;
                  });
                },
                obscureCvv: true,
                obscureNumber: false,
              ),
              const SizedBox(height: 25),
              MyButton(
                onTap: userTappedPay,
                text: "Pay Now",
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
