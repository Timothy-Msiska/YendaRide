import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RideBookingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RideBookingPage extends StatelessWidget {
  final Color primaryColor = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Placeholder for Map
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: Colors.grey.shade300,
            child: Center(child: Text("Map View", style: TextStyle(fontSize: 20))),
          ),

          // Bottom sheet section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16),
              height: 420,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Locations
                  Row(
                    children: [
                      Icon(Icons.radio_button_checked, color: Colors.red),
                      SizedBox(width: 10),
                      Text("Lusaka International Airport"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.circle_outlined, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("Waterfalls hotel • 27 min"),
                    ],
                  ),
                  Divider(height: 30),

                  // Ride options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rideOption("Economy", "K130", selected: true),
                      rideOption("Comfort", "K146"),
                      rideOption("Comfort+", "K159"),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Fare and controls
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.remove_circle_outline),
                        Column(
                          children: [
                            Text("K130", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text("Looks like a fair offer", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Icon(Icons.add_circle_outline),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Find driver button
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Find driver", style: TextStyle(fontSize: 16, color: Colors.white)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget rideOption(String title, String price, {bool selected = false}) {
    return Column(
      children: [
        Icon(Icons.directions_car, size: 30, color: selected ? Colors.black : Colors.grey),
        SizedBox(height: 5),
        Text(title),
        Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
