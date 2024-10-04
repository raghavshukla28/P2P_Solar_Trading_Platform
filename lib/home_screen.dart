import 'package:flutter/material.dart';
import 'trading_screen.dart'; // Import the TradingScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('P2P Solar Energy Trading'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the TradingScreen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TradingScreen()),
            );
          },
          child: Text('Start Trading Now'),
        ),
      ),
    );
  }
}
