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
  void _showEditSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        TextEditingController usernameController = TextEditingController(text: username);
        TextEditingController emailController = TextEditingController(text: email);
        TextEditingController contactController = TextEditingController(text: contact);
        TextEditingController addressController = TextEditingController(text: address);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField("Username", usernameController),
                    _buildTextField("Email", emailController),
                    _buildTextField("Contact", contactController),
                    _buildTextField("Address", addressController),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: [
                        ...avatarList.map((avatar) {
                          return GestureDetector(
                            onTap: () => setModalState(() {
                              selectedAvatar = avatar;
                              customImagePath = null;
                              customImage = null;
                            }),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(avatar),
                              radius: 30,
                              child: selectedAvatar == avatar && customImagePath == null
                                  ? const Icon(Icons.check, color: Colors.white)
                                  : null,
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: () async {
                            await _pickCustomImage();
                            setModalState(() {}); // refresh UI
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 30,
                            backgroundImage: customImage != null ? FileImage(customImage!) : null,
                            child: customImage == null
                                ? const Icon(Icons.add_a_photo)
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('username', usernameController.text);
                        await prefs.setString('email', emailController.text);
                        await prefs.setString('contact', contactController.text);
                        await prefs.setString('address', addressController.text);
                        await prefs.setString('avatar', selectedAvatar);

                        setState(() {
                          username = usernameController.text;
                          email = emailController.text;
                          contact = contactController.text;
                          address = addressController.text;
                        });

                        Navigator.pop(context);
                        _showUpdatedDialog();
                      },
                      child: const Text("Save Changes"),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void _showUpdatedDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Profile Updated"),
        content: const Text("Your profile has been saved."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildProfileTile(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = customImage != null
        ? FileImage(customImage!)
        : AssetImage(selectedAvatar) as ImageProvider;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickCustomImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageWidget,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: const Icon(Icons.edit, size: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileTile("Username", username),
              _buildProfileTile("Email", email),
              _buildProfileTile("Contact", contact),
              _buildProfileTile("Address", address),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showEditSheet,
                child: const Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
