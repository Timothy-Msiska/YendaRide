import 'package:flutter/material.dart';
import 'package:uber/views/logout.dart';
import 'package:uber/views/service_class.dart';
import 'package:uber/views/contact_support.dart';
import 'package:uber/views/user_agreement.dart';
import 'package:uber/views/saved_places.dart';
import 'package:uber/views/order_history.dart';
import 'package:uber/views/payment_methods.dart';
import 'package:uber/views/promo.dart';

class ProfileSettingsPage extends StatelessWidget {
  final String name = 'Timothy Msiska';
  final String phone = '+265882761779';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.close, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.yellow),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.account_circle, color: Colors.yellow, size: 40),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          phone,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.yellow, height: 1),
            buildOption(context, Icons.headset_mic, 'Contact Support', destination: ContactSupportPage()),
            buildOption(context, Icons.history, 'Order history', destination: OrderHistoryPage()),
            buildOption(context, Icons.payment, 'Payment methods', destination: PaymentMethodsPage()),
            buildOption(context, Icons.card_giftcard, 'Promo codes', destination: PromoCodesPage()),
            buildOption(context, Icons.place, 'Saved places', destination: SavedPlacesPage()),
            buildOption(context, Icons.local_taxi, 'Service classes', destination: ServiceClassesPage()),
            buildOption(context, Icons.description, 'User agreement', destination: UserAgreementPage()),
            Spacer(),
            Divider(color: Colors.yellow, height: 1),
            buildOption(context, Icons.logout, 'Log out', isLogout: true, destination: LogoutPage()),
            SizedBox(height: 8),
            Text(
              '© 2025 MLU B.V.\nv. 4.83.1',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, IconData? icon, String text, {
    bool isLogout = false,
    Widget? destination,
  }) {
    return Column(
      children: [
        ListTile(
          leading: icon != null
              ? Icon(icon, color: isLogout ? Colors.red : Colors.yellow)
              : null,
          title: Text(
            text,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.yellow,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {
            if (destination != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => destination),
              );
            }
          },
        ),
        Divider(color: Colors.grey[800], height: 1),
      ],
    );
  }
}
