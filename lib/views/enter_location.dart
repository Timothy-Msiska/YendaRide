import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:uber/views/ride_summary.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Add this package for geocoding

class EnterLocationPage extends StatefulWidget {
  const EnterLocationPage({super.key});

  @override
  _EnterLocationPageState createState() => _EnterLocationPageState();
}

class _EnterLocationPageState extends State<EnterLocationPage> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  TextEditingController searchController = TextEditingController();

  LatLng? currentPosition;
  LatLng? selectedLocation; // Track the selected location
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _initGooglePlace();
    _getCurrentLocation(); // Try to get current location on init
  }

  void _initGooglePlace() {
    const String apiKey = "AIzaSyCxaal1vxz1BN_psuhoBBMfZ-oxhh5ClCo";
    googlePlace = GooglePlace(apiKey);
  }

  // Method to get current location (you'll need to implement this properly)
  void _getCurrentLocation() async {
    // This is a placeholder - in a real app, you'd use the location plugin
    // For now, we'll just set a default position
    setState(() {
      currentPosition = LatLng(-13.9626, 33.7741); // Default to Malawi
    });
  }

  void autoCompleteSearch(String value) async {
    if (value.isNotEmpty) {
      var result = await googlePlace.autocomplete.get(value);
      if (result != null && result.predictions != null && mounted) {
        setState(() {
          predictions = result.predictions!;
        });
      }
    } else {
      setState(() {
        predictions = [];
      });
    }
  }

  void selectPrediction(AutocompletePrediction prediction) async {
    try {
      // Convert the prediction to coordinates
      List<Location> locations = await locationFromAddress(
        prediction.description ?? "",
      );
      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          predictions = [];
          searchController.text = prediction.description ?? "";
          selectedLocation = LatLng(location.latitude, location.longitude);
        });

        // Move the camera to the selected location
        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(selectedLocation!, 15),
        );
      }
    } catch (e) {
      print("Error getting location: $e");
      // Handle error (maybe show a snackbar)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target:
                    selectedLocation ??
                    currentPosition ??
                    LatLng(-13.9626, 33.7741),
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(16),
                    child: TextField(
                      controller: searchController,
                      onChanged: autoCompleteSearch,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter destination',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.yellow),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                  if (predictions.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.yellow,
                            ),
                            title: Text(
                              predictions[index].description ?? "",
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => selectPrediction(predictions[index]),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (selectedLocation != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => RideSummaryPage(
                        destinationName: searchController.text,
                        location: selectedLocation!,
                      ),
                ),
              );
            } else {
              // Show error if no location selected
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Please select a destination'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Continue',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
