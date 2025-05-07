import 'package:flutter/material.dart';
import 'package:uber/views/name_registration.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final TextEditingController phoneController = TextEditingController();
  bool isAgreed = false; // checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'YANGA',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    letterSpacing: 2,
                  ),
                ),
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ENTER YOUR PHONE NUMBER',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'We will send a confirmation code to it',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/images/Flag-of-Malawi.png', // Ensure filename case is correct
                      width: 20,
                      height: 20,
                    ),
                  ),
                  hintText: '+265 (00) 000 0000',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  suffixIcon: Icon(Icons.clear, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: isAgreed,
                    onChanged: (value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                    activeColor: Colors.yellow,
                    checkColor: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      'I accept the User Agreement and Privacy Policy',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: isAgreed
                      ? () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EnterNamePage()),
                    );
                  }
                    : null, // Disabled when not agreed
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 20),
              Text(
                'By ticking, I accept the terms of the User Agreement\nand Yanga License Agreement and consent to the\nprocessing of my personal information in accordance\nwith the Privacy Policy.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
