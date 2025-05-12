import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideBookingPage extends StatelessWidget {
  final LatLng currentLocation;
  final LatLng nextDestination;

  const RideBookingPage({
    required this.currentLocation,
    required this.nextDestination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text("Ride Summary", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car, size: 100, color: Colors.yellow[700]),
            SizedBox(height: 20),
            Text(
              "Current Location:\n${currentLocation.latitude}, ${currentLocation.longitude}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Next Destination:\n${nextDestination.latitude}, ${nextDestination.longitude}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
