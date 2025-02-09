import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/screens/biometric_helper.dart';
import 'package:shopping_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAuthenticated = false;
  bool isLoading = true;
  User? user;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    final biometricHelper = BiometricHelper();
    bool authenticated = await biometricHelper.authenticate();

    setState(() {
      isAuthenticated = authenticated;
      isLoading = false;
      if (authenticated) {
        user = FirebaseAuth.instance.currentUser;
      }
    });

    if (!authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isAuthenticated
              ? _buildProfile()
              : const Center(
                  child: Text("Please authenticate to access your profile")),
    );
  }

  Widget _buildProfile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  user!.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child:
                  user!.photoURL == null ? Icon(Icons.person, size: 50) : null,
            ),
            const SizedBox(height: 20),
            Text(user!.displayName ?? "Name not available",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(user!.email ?? "Email not available",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
