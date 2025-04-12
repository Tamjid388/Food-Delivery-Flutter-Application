import 'package:flutter/material.dart';
import 'package:food_delivery_app/intro/intro_page_1.dart';
import 'package:food_delivery_app/intro/intro_page_2.dart';
import 'package:food_delivery_app/intro/intro_page_3.dart';
import 'package:food_delivery_app/services/auth/auth_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  // Function to save intro completion
  Future<void> _completeIntro() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenIntro', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthGate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with separate intro pages
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // Bottom navigation controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip button
                GestureDetector(
                  onTap: () => _controller.jumpToPage(2),
                  child: const Text("Skip"),
                ),

                // Page indicator
                SmoothPageIndicator(controller: _controller, count: 3),

                // Next or Done button
                GestureDetector(
                  onTap: () {
                    if (onLastPage) {
                      _completeIntro();
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutSine,
                      );
                    }
                  },
                  child: Text(onLastPage ? 'Done' : 'Next'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
