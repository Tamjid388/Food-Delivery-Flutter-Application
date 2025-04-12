// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/restauarant.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class ProfileCreationPage extends StatefulWidget {
  const ProfileCreationPage({super.key});

  @override
  _ProfileCreationPageState createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<ProfileCreationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  int _selectedAvatarIndex = 0;

  final List<String> _avatars = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
  ];

  Future<void> _saveProfile() async {
    String email = _emailController.text.trim();
    String contact = _contactController.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final contactRegex = RegExp(r'^\d{7,15}$');

    if (_usernameController.text.isEmpty ||
        email.isEmpty ||
        contact.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
          backgroundColor: Color(0xFFFFA825),
        ),
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid email address."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    if (!contactRegex.hasMatch(contact)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Contact number must be digits only (7–15 digits)."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', email);
    await prefs.setString('contact', contact);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('avatar', _avatars[_selectedAvatarIndex]);
    await prefs.setBool('isProfileCreated', true);

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username': _usernameController.text,
        'email': email,
        'contact': contact,
        'address': _addressController.text,
        'avatar': _avatars[_selectedAvatarIndex],
        'createdAt': Timestamp.now(),
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save profile to Firebase: $e"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<Restauarant>().updateDeliveryAddress(_addressController.text);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset('assets/profile_created.json', repeat: false,
                  onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                });
              }),
              const SizedBox(height: 10),
              const Text(
                "Profile Created Successfully!",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Profile",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFFFFA825),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(_avatars[_selectedAvatarIndex]),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Choose an Avatar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _avatars.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAvatarIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: _selectedAvatarIndex == index
                                ? Color.fromARGB(255, 186, 113, 3)
                                    .withOpacity(0.5)
                                : Colors.grey.withOpacity(0.3),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(_avatars[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(_usernameController, "Username", Icons.person,
                TextInputType.text),
            const SizedBox(height: 12),
            _buildTextField(_emailController, "Email", Icons.email,
                TextInputType.emailAddress,
                isEmail: true),
            const SizedBox(height: 12),
            _buildTextField(_contactController, "Contact Number", Icons.phone,
                TextInputType.phone,
                isPhone: true),
            const SizedBox(height: 12),
            _buildTextField(_addressController, "Address", Icons.location_on,
                TextInputType.text),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Color(0xFFFFA825),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _saveProfile,
                child: const Text("Create Profile",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint,
      IconData icon, TextInputType keyboardType,
      {bool isEmail = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (isPhone ? TextInputType.phone : keyboardType),
      inputFormatters:
          isPhone ? [FilteringTextInputFormatter.digitsOnly] : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Color.fromARGB(255, 255, 198, 113)),
        labelText: hint,
        labelStyle: TextStyle(color: Color.fromARGB(255, 255, 194, 103)),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
