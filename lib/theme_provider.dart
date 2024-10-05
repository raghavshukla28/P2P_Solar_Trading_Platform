import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isDarkTheme = false;

  ThemeData get themeData {
    return isDarkTheme ? darkTheme() : lightTheme();
  }

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1F1F1F), // Softer dark gray
      primaryColor: Color(0xFF2C2C2C), // Darker gray, not pitch black
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF2A2A2A), // Dark but not black
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4A4A4A), // Same for elevated buttons
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF3C3C3C), // Dark gray for FABs
        foregroundColor: Colors.yellow[700],
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white), // Updated from bodyText1
        bodyMedium: TextStyle(color: Colors.white70), // Updated from bodyText2
        titleLarge: TextStyle(color: Colors.white), // Updated from headline6
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.yellow[700],
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.yellow[700],
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow[700],
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black), // Updated from bodyText1
        bodyMedium: TextStyle(color: Colors.black87), // Updated from bodyText2
        titleLarge: TextStyle(color: Colors.black), // Updated from headline6
      ),
    );
  }
}
