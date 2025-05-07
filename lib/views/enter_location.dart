import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';

class EnterLocationPage extends StatefulWidget {
  @override
  _EnterLocationPageState createState() => _EnterLocationPageState();
}

class _EnterLocationPageState extends State<EnterLocationPage> {
  LatLng? currentPosition;
  GoogleMapController? mapController;
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initGooglePlace();
    _determinePosition();
  }

  void _initGooglePlace() {
    const String apiKey = "AIzaSyCxaal1vxz1BN_psuhoBBMfZ-oxhh5ClCo";
    googlePlace = GooglePlace(apiKey);
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
    var details = await googlePlace.details.get(prediction.placeId!);
    if (details != null && details.result != null && details.result!.geometry != null) {
      final loc = details.result!.geometry!.location!;
      final LatLng pos = LatLng(loc.lat!, loc.lng!);
      mapController?.animateCamera(CameraUpdate.newLatLng(pos));
      setState(() {
        currentPosition = pos;
        predictions = [];
        searchController.text = prediction.description!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          currentPosition == null
              ? Center(child: CircularProgressIndicator(color: Colors.red))
              : GoogleMap(
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
                      decoration: InputDecoration(
                        hintText: 'Where from?',
                        prefixIcon: Icon(Icons.search, color: Colors.red),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                  if (predictions.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: predictions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(predictions[index].description ?? ""),
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Location sent: ${currentPosition?.latitude}, ${currentPosition?.longitude}',
              ),
              backgroundColor: Colors.yellow,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(
            'Send Location',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
