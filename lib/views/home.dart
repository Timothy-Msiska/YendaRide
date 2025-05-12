import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber/views/enter_location.dart';
import 'package:uber/views/settings.dart';
import 'package:uber/views/ride_booking.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LatLng? currentPosition;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Location error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Yenda Ride', style: TextStyle(color: Colors.yellow)),
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.yellow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
              );
            },
          ),
        ],
      ),
      body: currentPosition == null
          ? Center(child: CircularProgressIndicator(color: Colors.yellow))
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (controller) {
              mapController = controller;
            },
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Location sent: ${currentPosition?.latitude}, ${currentPosition?.longitude}',
                    ),
                    backgroundColor: Colors.yellow,
                    behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 2),
                  ),
                );

                Future.delayed(Duration(milliseconds: 500), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EnterLocationPage()),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Send my current location',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
