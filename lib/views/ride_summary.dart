import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geoCoding;

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
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _initGooglePlace();
    _getCurrentLocation();
  }

  void _initGooglePlace() {
    const String apiKey = "AIzaSyCxaal1vxz1BN_psuhoBBMfZ-oxhh5ClCo";
    googlePlace = GooglePlace(apiKey);
  }

  void _getCurrentLocation() async {
    setState(() {
      currentPosition = LatLng(-13.9626, 33.7741);
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
      List<geoCoding.Location> locations = await geoCoding.locationFromAddress(
        prediction.description ?? "",
      );

      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          predictions = [];
          searchController.text = prediction.description ?? "";
          selectedLocation = LatLng(location.latitude, location.longitude);
        });

        mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(selectedLocation!, 15),
        );
      }
    } catch (e) {
      print("Error getting location: $e");
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
                target: selectedLocation ?? currentPosition ?? LatLng(-13.9626, 33.7741),
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
                            leading: Icon(Icons.location_on, color: Colors.yellow),
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
                  builder: (context) => RideSummaryPage(
                    destinationName: searchController.text,
                    destinationLocation: selectedLocation!,
                  ),
                ),
              );
            } else {
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

class RideSummaryPage extends StatelessWidget {
  final String destinationName;
  final LatLng destinationLocation;

  const RideSummaryPage({
    Key? key,
    required this.destinationName,
    required this.destinationLocation,
  }) : super(key: key);

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
                children: [
                  const Text(
                    'Drivers are 5 min away',
                    style: TextStyle(color: Colors.yellow, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'The driver will pick\nyou up at:',
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    destinationName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),

            // Rest of your UI remains the same:
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
                    children: [
                      const Icon(Icons.radio_button_checked, color: Colors.yellow),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          destinationName,
                          style: const TextStyle(color: Colors.yellow, fontSize: 16),
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
                          'EcoBank, Area 14 • 8min & 4kms',
                          style: TextStyle(color: Colors.yellow, fontSize: 16),
                        ),
                      ),
                      Icon(Icons.add, color: Colors.yellow),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RideOption(title: 'Standard', price: 'MwK 1500 /kms'),
                      RideOption(title: 'Medium ', price: 'MwK 3000 /kms'),
                      RideOption(title: 'Premium', price: 'MwK 9000 /kms'),
                    ],
                  ),
                  SizedBox(height: 20),

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
            ),
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
