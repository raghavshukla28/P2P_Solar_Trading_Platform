import 'package:flutter/material.dart';

class TradingScreen extends StatefulWidget {
  @override
  _TradingScreenState createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  bool isBuying = true; // True if buying, false if selling
  double energyAmount = 0.0;
  double price = 0.0;

  // Controllers to handle input
  final TextEditingController _energyController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Method to handle negotiation
  void _negotiate() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Negotiate Price'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Price: \$${price.toStringAsFixed(2)}'),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Enter your price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                double newPrice = double.tryParse(_priceController.text) ?? price;
                setState(() {
                  price = newPrice; // Update price based on negotiation
                });
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Negotiate'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
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
        title: Text('Trading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Option to buy or sell
            ToggleButtons(
              isSelected: [isBuying, !isBuying],
              onPressed: (int index) {
                setState(() {
                  isBuying = index == 0;
                });
              },
              children: [Text('Buy'), Text('Sell')],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _energyController,
              decoration: InputDecoration(
                labelText: isBuying ? 'Amount of Energy to Buy' : 'Amount of Energy to Sell',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: isBuying ? 'Your Offer Price' : 'Your Sell Price',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  energyAmount = double.tryParse(_energyController.text) ?? 0.0;
                  price = double.tryParse(_priceController.text) ?? 0.0;
                });
                _negotiate(); // Call negotiation logic
              },
              child: Text(isBuying ? 'Buy Energy' : 'Sell Energy'),
            ),
          ],
        ),
      ),
    );
  }
}
