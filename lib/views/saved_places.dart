import 'package:flutter/material.dart';

class SavedPlacesPage extends StatefulWidget {
  @override
  _SavedPlacesPageState createState() => _SavedPlacesPageState();
}

class _SavedPlacesPageState extends State<SavedPlacesPage> {
  List<Map<String, String>> savedPlaces = [
    {'label': 'Home', 'address': 'Njewa, Lilongwe'},
    {'label': 'Work', 'address': 'City Center, Lilongwe'},
  ];

  void _addPlace() {
    showDialog(
      context: context,
      builder: (context) {
        String label = '';
        String address = '';

        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Add Place', style: TextStyle(color: Colors.yellow)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Label',
                  labelStyle: TextStyle(color: Colors.yellow),
                  hintText: 'e.g., School',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) => label = value,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.yellow),
                  hintText: 'e.g., Chichiri, Blantyre',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onChanged: (value) => address = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: Text('Save', style: TextStyle(color: Colors.black)),
              onPressed: () {
                if (label.isNotEmpty && address.isNotEmpty) {
                  setState(() {
                    savedPlaces.add({'label': label, 'address': address});
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _removePlace(int index) {
    setState(() {
      savedPlaces.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Saved Places"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      body: savedPlaces.isEmpty
          ? Center(
        child: Text(
          "No saved places yet.\nTap + to add.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: savedPlaces.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey[800]),
        itemBuilder: (context, index) {
          final place = savedPlaces[index];
          return ListTile(
            leading: Icon(Icons.place, color: Colors.yellow),
            title: Text(place['label']!, style: TextStyle(color: Colors.white)),
            subtitle: Text(place['address']!, style: TextStyle(color: Colors.grey[400])),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _removePlace(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: _addPlace,
        tooltip: 'Add Saved Place',
      ),
    );
  }
}
