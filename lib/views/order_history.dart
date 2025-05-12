import 'package:flutter/material.dart';
import 'dart:math';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  List<Map<String, String>> orderHistory = [
    {'orderId': '1234', 'date': '2025-05-01', 'status': 'Completed'},
    {'orderId': '5678', 'date': '2025-04-20', 'status': 'Cancelled'},
    {'orderId': '91011', 'date': '2025-04-18', 'status': 'Completed'},
    {'orderId': '121314', 'date': '2025-04-15', 'status': 'Pending'},
    {'orderId': '151617', 'date': '2025-04-10', 'status': 'Completed'},
    {'orderId': '181920', 'date': '2025-04-05', 'status': 'Failed'},
    {'orderId': '212223', 'date': '2025-03-28', 'status': 'Completed'},
    {'orderId': '242526', 'date': '2025-03-22', 'status': 'Pending'},
    {'orderId': '272829', 'date': '2025-03-18', 'status': 'Completed'},
    {'orderId': '303132', 'date': '2025-03-10', 'status': 'Cancelled'},
  ];

  void _refreshOrderHistory() {
    setState(() {
      // Shuffle the orderHistory list to randomize the order
      orderHistory.shuffle(Random());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
      ),
      backgroundColor: Colors.black,
      body: orderHistory.isEmpty
          ? Center(
        child: Text(
          "No order history available.\nTap the refresh button.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.yellow, fontSize: 16),
        ),
      )
          : ListView.separated(
        itemCount: orderHistory.length,
        separatorBuilder: (context, index) =>
            Divider(color: Colors.grey[800]),
        itemBuilder: (context, index) {
          final order = orderHistory[index];
          return ListTile(
            title: Text('Order ID: ${order['orderId']}',
                style: TextStyle(color: Colors.white)),
            subtitle: Text(
                'Date: ${order['date']} - Status: ${order['status']}',
                style: TextStyle(color: Colors.grey[400])),
            onTap: () {
              // Handle order details (you could navigate to a details page here)
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: Colors.grey[900],
                    title:
                    Text('Order Details', style: TextStyle(color: Colors.yellow)),
                    content: Text(
                        'Order ID: ${order['orderId']}\nDate: ${order['date']}\nStatus: ${order['status']}'),
                    actions: [
                      TextButton(
                        child: Text('Close', style: TextStyle(color: Colors.yellow)),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: Icon(Icons.refresh, color: Colors.black),
        onPressed: _refreshOrderHistory,
        tooltip: 'Shuffle Order History',
      ),
    );
  }
}
