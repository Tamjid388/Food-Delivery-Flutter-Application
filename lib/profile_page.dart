import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "", email = "", contact = "", address = "";
  String selectedAvatar = "assets/avatars/avatar1.png";
  String? customImagePath;
  File? customImage;

  final List<String> avatarList = [
    "assets/avatars/avatar1.png",
    "assets/avatars/avatar2.png",
    "assets/avatars/avatar3.png",
    "assets/avatars/avatar4.png",
    "assets/avatars/avatar5.png",
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "Guest";
      email = prefs.getString('email') ?? "Not Set";
      contact = prefs.getString('contact') ?? "Not Set";
      address = prefs.getString('address') ?? "Not Set";
      selectedAvatar = prefs.getString('avatar') ?? avatarList[0];
      customImagePath = prefs.getString('customImagePath');
      if (customImagePath != null) customImage = File(customImagePath!);
    });
  }

  Future<void> _pickCustomImage() async {
    final picker = ImagePicker();
    final status = await Permission.photos.request();

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission denied")),
      );
      return;
    }

    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = picked.name;
    final savedImage = await File(picked.path).copy('${appDir.path}/$fileName');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('customImagePath', savedImage.path);

    setState(() {
      customImagePath = savedImage.path;
      customImage = File(savedImage.path);
    });
  }