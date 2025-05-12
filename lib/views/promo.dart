import 'package:flutter/material.dart';

class PromoCodesPage extends StatefulWidget {
  @override
  _PromoCodesPageState createState() => _PromoCodesPageState();
}

class _PromoCodesPageState extends State<PromoCodesPage> {
  List<String> promoCodes = ['SAVE10', 'FREESHIP', 'DISCOUNT20'];

  void _addPromoCode() {
    showDialog(
      context: context,
      builder: (context) {
        String newPromoCode = '';

        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text('Add Promo Code', style: TextStyle(color: Colors.yellow)),
          content: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Promo Code',
              labelStyle: TextStyle(color: Colors.yellow),
              hintText: 'Enter promo code',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) => newPromoCode = value,
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
                if (newPromoCode.isNotEmpty) {
                  setState(() {
                    promoCodes.add(newPromoCode);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Promo Codes"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.black,
      body: promoCodes.isEmpty
          ? Center(
        child: Text(
          "No promo codes available.\nTap + to add.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: promoCodes.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[800]),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(promoCodes[index], style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  promoCodes.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.black),
        onPressed: _addPromoCode,
        tooltip: 'Add Promo Code',
      ),
    );
  }
}
