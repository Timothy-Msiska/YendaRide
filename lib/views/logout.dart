import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber/views/register.dart'; // Ensure this has PhoneLoginPage

class LogoutPage extends StatelessWidget {
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Clear stored user session or login flags
    await prefs.clear(); // or prefs.remove('key') for selective clearing

    // Navigate to login or welcome screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => PhoneLoginPage()),
          (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Log Out"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: Colors.yellow, size: 80),
              SizedBox(height: 20),
              Text(
                "Are you sure you want to log out?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text("Log Out"),
                onPressed: () => _logout(context),
              ),
              TextButton(
                child: Text("Cancel", style: TextStyle(color: Colors.grey)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
