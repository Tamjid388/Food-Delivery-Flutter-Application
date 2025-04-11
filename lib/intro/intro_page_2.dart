import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/f_r.json',
            width: 250,
            height: 300,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),
          const Text(
            'Your Food is Ready ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 23.0),
            child: Text(
              'Get your food with full of Hygiene and Taste.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
