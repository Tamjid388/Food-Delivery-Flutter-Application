import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // Function to launch Email
  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(scheme: 'mailto', path: 'raziunhasan@gmail.com');
    if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch email');
    }
  }

  // Function to launch Phone
  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+8801945509105');
    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch phone');
    }
  }

  // Function to launch Google Maps
  Future<void> _launchMap() async {
    final Uri mapUri = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=Mirpur-14,Dhaka,Bangladesh",
    );
    if (!await launchUrl(mapUri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch map');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Color.fromRGBO(66, 66, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to foodos!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              "    foodos is a modern food delivery platform committed to providing customers with a seamless and efficient way to enjoy their favorite meals. "
              "With a user-friendly interface and a vast selection of cuisines, we bring the best restaurants to your doorstep, ensuring a hassle-free dining experience from the comfort of your home.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              "    We prioritize customer satisfaction by maintaining high service standards, offering real-time order tracking, and ensuring timely deliveries. "
              "Our dedicated team continuously works on improving the platform, incorporating the latest technological advancements to enhance your ordering experience.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              "    Whether you're craving a quick snack, a hearty meal, or something new to try, Zaika connects you with the best options available. "
              "We strive to make food delivery convenient, reliable, and enjoyable for everyone, anytime and anywhere.",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("raziunhasan@gmail.com"),
              onTap: _launchEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text("01945509105"),
              onTap: _launchPhone,
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text("mirpur14, Dhaka, Bangladesh"),
              onTap: _launchMap,
            ),
            const SizedBox(height: 80),
            Center(
              child: Text(
                "Copyright © 2025 foodos. All Rights Reserved",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
