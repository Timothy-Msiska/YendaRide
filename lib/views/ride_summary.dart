import 'package:flutter/material.dart';

class RideSummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Drivers are 5 min away',
                    style: TextStyle(color: Colors.yellow, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The driver will pick\nyou up where you are',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Show map button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: StadiumBorder(),
                    ),
                    icon: Icon(Icons.alt_route),
                    label: Text('Show map'),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            // Location Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(Icons.radio_button_checked, color: Colors.yellow),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Area 46, Njewa',
                          style: TextStyle(color: Colors.yellow, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.yellow),
                  Row(
                    children: const [
                      Icon(Icons.radio_button_unchecked, color: Colors.yellow),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'EcoBank, Aera 14 • 8min & 4kms',
                          style: TextStyle(color: Colors.yellow, fontSize: 16),
                        ),
                      ),
                      Icon(Icons.add, color: Colors.yellow),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Ride Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RideOption(title: 'Standard', price: 'MwK 1500 /kms'),
                      RideOption(title: 'Medium ', price: 'MwK 3000 /kms'),
                      RideOption(title: 'Premium', price: 'MwK 9000 /kms'),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Price & Adjuster
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.remove, color: Colors.black),
                        ),
                        Column(
                          children: [
                            Text(
                              'Mwk 6000',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Looks like a fair offer',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Find Driver Button
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.local_taxi),
                    label: Text(
                      'Find driver',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RideOption extends StatelessWidget {
  final String title;
  final String price;

  const RideOption({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.directions_car, color: Colors.yellow),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: Colors.yellow),
          ),
          Text(
            price,
            style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
