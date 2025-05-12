import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatefulWidget {
  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  List<String> paymentMethods = [
    'Airtel Money - +265 999 123 456',
    'TNM Mpamba - +265 888 987 654',
    'Visa Card - **** **** **** 1234'
  ];

  void _addPaymentMethod() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        String selectedMethod = 'Airtel Money';
        String input = '';

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Payment Method',
                style: TextStyle(color: Colors.yellow, fontSize: 18),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                dropdownColor: Colors.black,
                value: selectedMethod,
                style: TextStyle(color: Colors.yellow),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(),
                  labelText: 'Method',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                ),
                items: ['Airtel Money', 'TNM Mpamba', 'Visa/MasterCard']
                    .map((method) => DropdownMenuItem(
                  value: method,
                  child: Text(method),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMethod = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextField(
                style: TextStyle(color: Colors.yellow),
                decoration: InputDecoration(
                  labelText: selectedMethod == 'Visa/MasterCard'
                      ? 'Card Number'
                      : 'Phone Number',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(),
                ),
                keyboardType: selectedMethod == 'Visa/MasterCard'
                    ? TextInputType.number
                    : TextInputType.phone,
                onChanged: (val) => input = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  if (input.isNotEmpty) {
                    setState(() {
                      if (selectedMethod == 'Visa/MasterCard') {
                        paymentMethods.add('Visa Card - **** **** **** ${input.substring(input.length - 4)}');
                      } else {
                        paymentMethods.add('$selectedMethod - $input');
                      }
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Method'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeMethod(int index) {
    setState(() {
      paymentMethods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Payment Methods"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.yellow),
            onPressed: _addPaymentMethod,
          ),
        ],
      ),
      body: paymentMethods.isEmpty
          ? Center(
        child: Text(
          "No payment methods added.",
          style: TextStyle(color: Colors.grey),
        ),
      )
          : ListView.separated(
        itemCount: paymentMethods.length,
        separatorBuilder: (_, __) => Divider(color: Colors.grey[800]),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.payment, color: Colors.yellow),
            title: Text(
              paymentMethods[index],
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeMethod(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPaymentMethod,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
