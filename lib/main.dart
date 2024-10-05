import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import the theme provider
import 'your_main_app_file.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: SolarEnergyTradingApp(), // Call your main app here
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Your App Title',
      theme: themeProvider.themeData,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Toggle App'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkTheme ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: () {
              themeProvider.toggleTheme(); // Toggle theme
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Current Theme: ${themeProvider.isDarkTheme ? 'Dark' : 'Light'}',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}


