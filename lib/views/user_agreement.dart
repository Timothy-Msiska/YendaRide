import 'package:flutter/material.dart';

class UserAgreementPage extends StatelessWidget {
  final String agreementText = '''
Welcome to Yenda Ride!

By using the Yenda Ride application ("Yenda", "we", "our", or "us"), you agree to the following terms and conditions. Please read them carefully.

1. USER ELIGIBILITY
You must be at least 18 years old to use this service. You are responsible for ensuring your personal information is accurate.

2. SERVICE OVERVIEW
Yenda is a platform that connects passengers with independent drivers. We are not responsible for the conduct of drivers or users.

3. BOOKING A RIDE
All bookings are made through the app. Fares are calculated based on distance, class of service (Standard, Middle, Premium), and time. You agree to pay the fare shown upon booking confirmation.

4. PAYMENT
Accepted payment methods include:
• Airtel Money
• TNM Mpamba
• Visa/MasterCard
You agree to authorize Yenda to charge your selected method after ride completion.

5. RIDE CONDUCT
Passengers and drivers must behave respectfully. Abuse, harassment, or damage to property will result in account suspension or ban.

6. CANCELLATIONS
Riders may cancel rides under certain conditions. Repeated cancellations or no-shows may attract fees.

7. LIABILITY
Yenda is not liable for delays, accidents, or losses during rides. We recommend you keep personal belongings secure at all times.

8. ACCOUNT TERMINATION
We reserve the right to suspend or terminate any account for violations of this agreement or misuse of the platform.

9. PRIVACY
Your personal data is collected in line with our Privacy Policy. We do not sell user information to third parties.

10. CHANGES TO TERMS
These terms may be updated periodically. Continued use of the app means you agree to the latest version.

For questions or concerns, contact support@yendaride.mw

Thank you for choosing Yenda. Ride easy, ride safe.
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("User Agreement"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            agreementText,
            style: TextStyle(
              color: Colors.yellow[100],
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
