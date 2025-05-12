import 'package:flutter/material.dart';

class ServiceClassesPage extends StatelessWidget {
  final List<RideClass> rideClasses = [
    RideClass(
      title: "Standard Class",
      description: "Affordable everyday rides with compact vehicles. Ideal for individuals or small groups.",
      features: ["4 Seater", "AC Available", "Low Fare"],
      cars: ["Toyota Vitz", "Nissan March", "Honda Fit"],
      imageUrls: [
        "https://upload.wikimedia.org/wikipedia/commons/6/6c/Toyota_Vitz_2019.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/e/e7/Nissan_March.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/2/2d/Honda_Fit_front.jpg",
      ],
    ),
    RideClass(
      title: "Middle Class",
      description: "Spacious rides with mid-range sedans and more comfort.",
      features: ["Comfortable Seating", "Good Luggage Space", "AC"],
      cars: ["Toyota Corolla", "Mazda Axela", "Nissan Bluebird"],
      imageUrls: [
        "https://upload.wikimedia.org/wikipedia/commons/0/05/2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_CVT_1.8_Front.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/2/28/Mazda_Axela.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/f/f5/Nissan_Bluebird_Sylphy.jpg",
      ],
    ),
    RideClass(
      title: "Premium Class",
      description: "High-end vehicles for luxury, style, and executive comfort.",
      features: ["Leather Seats", "Spacious Interior", "Priority Support"],
      cars: ["Toyota Fortuner", "Mercedes-Benz C-Class", "Range Rover Evoque"],
      imageUrls: [
        "https://upload.wikimedia.org/wikipedia/commons/7/72/2016_Toyota_Fortuner_%28GUN156R%29_Crusade_wagon_%282018-08-06%29_01.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/f/f2/Mercedes_C_200_Avantgarde_2018.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/f/fc/Range_Rover_Evoque_SD4_Dynamic_–_Frontansicht%2C_30._August_2012%2C_D%C3%BCsseldorf.jpg",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Service Classes"), backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: rideClasses.length,
        itemBuilder: (context, index) {
          final ride = rideClasses[index];
          return Card(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ride.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow)),
                  SizedBox(height: 8),
                  Text(ride.description, style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ride.features.map((feature) => Chip(label: Text(feature), backgroundColor: Colors.blueAccent)).toList(),
                  ),
                  SizedBox(height: 10),
                  Text("Common Cars:", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  ...ride.cars.map((car) => Text("• $car", style: TextStyle(color: Colors.white70))),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: ride.imageUrls.length,
                      itemBuilder: (context, imgIndex) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(ride.imageUrls[imgIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RideClass {
  final String title;
  final String description;
  final List<String> features;
  final List<String> cars;
  final List<String> imageUrls;

  RideClass({
    required this.title,
    required this.description,
    required this.features,
    required this.cars,
    required this.imageUrls,
  });
}
