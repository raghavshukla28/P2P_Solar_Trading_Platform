import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Ensure to import your ThemeProvider file
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart'; // For haptic feedback
import 'package:audioplayers/audioplayers.dart';

class SolarEnergyTradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Create ThemeProvider instance
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'P2P Solar Energy Trading Platform',
            theme: themeProvider.themeData, // Use theme data from provider
            home: HomePage(), // Your existing HomePage widget
          );
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer(); // Create an instance of AudioPlayer

  // Function to play audio feedback
  void _playSound() async {
    await _audioPlayer.play(AssetSource('assets/sounds/button_click.mp3')); // Add your audio file path
  }

  // Function to give haptic feedback
  void _giveHapticFeedback() {
    HapticFeedback.lightImpact();
  }

  // Combining both haptic and audio feedback
  void _giveFeedback() {
    _giveHapticFeedback();
    _playSound();
  }

  void _openBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.blueGrey[200],
      builder: (context) {
        return SwipeablePanel(); // Call the new bottom sheet widget
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Get the ThemeProvider

    final List<Widget> carouselItems = [
      _buildCarouselItem('Start Trading Now', () {
        _giveFeedback(); // Adding feedback on button press
        // Define your action for this button
      }),
      _buildCarouselItem('Buy Solar Energy', () {
        _giveFeedback(); // Adding feedback on button press
        // Define your action for this button
      }),
      _buildCarouselItem('Sell Solar Energy', () {
        _giveFeedback(); // Adding feedback on button press
        // Define your action for this button
      }),
      _buildCarouselItem('View Trading History', () {
        _giveFeedback(); // Adding feedback on button press
        // Define your action for this button
      }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _giveFeedback(); // Adding feedback on title tap
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeveloperInfoScreen()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkTheme ? Colors.grey[850] : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
              'Solar Energy Trading',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkTheme ? Colors.yellow : Colors.yellow[700],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _giveFeedback(); // Adding feedback on search button press
            },
          ),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              _giveFeedback(); // Adding feedback on chat button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined),
            onPressed: () {
              _giveFeedback(); // Adding feedback on comment button press
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              themeProvider.isDarkTheme ? Icons.wb_sunny : Icons.nights_stay,
            ),
            onPressed: () {
              _giveFeedback(); // Adding feedback on theme toggle button press
              themeProvider.toggleTheme(); // Toggle the theme
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [themeProvider.isDarkTheme ? Colors.grey[800]! : Colors.white70, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Carousel Section
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                  items: carouselItems.map((widget) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: widget,
                        );
                      },
                    );
                  }).toList(),
                ),
                HeroSection(),
                TradingCardsSection(),
                UserFeedbackSection(),
              ],
            ),
          ),
          // Button to open the bottom sheet
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                _giveFeedback(); // Adding feedback on floating button press
                _openBottomSheet();
              },
              child: Icon(Icons.info_outline),
              backgroundColor: Colors.yellow[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String buttonText, VoidCallback onPressed) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Get the ThemeProvider
    return Container(
      decoration: BoxDecoration(
        color: themeProvider.isDarkTheme ? Colors.grey[850] : Colors.orangeAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: themeProvider.isDarkTheme ? Colors.grey[800] : Colors.white,
            foregroundColor: themeProvider.isDarkTheme ? Colors.orangeAccent : Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: themeProvider.isDarkTheme ? Colors.orange : Colors.orangeAccent,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class DeveloperInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Developer Info')),
      body: Center(
        child: Text(
          'Raghav is the developer',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Center(
        child: Text('No chats available.', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Feedback')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Share your opinion or feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String feedback = _controller.text;
                _controller.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Feedback submitted!')),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class SwipeablePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: MediaQuery.of(context).size.height * 0.6, // Set a height for the bottom sheet
      child: Column(
        children: [
          Text(
            'User Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Username: Raghav'),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Trading History: 10 trades'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications: 5'),
          ),
          ListTile(
            leading: Icon(Icons.tips_and_updates),
            title: Text('Tips & Insights'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle settings tap
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();  // Close the bottom sheet
            },
            child: Text('Close Panel'),
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the current theme brightness
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDarkMode
              ? [Colors.grey[900]!, Colors.grey[800]!]
              : [Colors.yellow[700]!, Colors.orange[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Solar Energy Trading',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
                foregroundColor: isDarkMode ? Colors.white : Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TradeSelectionScreen()),
                );
              },
              child: Text(
                'Start Trading Now',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.yellow[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TradingCardsSection extends StatelessWidget {
  final List<String> offers = [
    '10 kWh Solar Energy for Sale',
    'Buy 5 kWh Solar Energy',
    'Invest in Solar Project',
    'Sell your Solar Energy',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trading Offers',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        offers[index],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10), // Space between text and button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                        backgroundColor: Colors.transparent, // Make background transparent
                      ),
                      onPressed: () {
                        // Handle trade button press
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightGreen, Colors.green],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 150.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Trade',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Add TradeSelectionScreen and UserFeedbackSection classes if not already defined

class UserFeedbackSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Feedback',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeedbackCard('Great platform! Saved so much on my bills.'),
                FeedbackCard('Loved the trading experience. Very smooth!'),
                FeedbackCard('First time using this app, the UI is amazing.'),
                FeedbackCard('Excellent community support and features.'),
                FeedbackCard('Tum kya kaam krta h Raghav bhai.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String feedback;

  FeedbackCard(this.feedback);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(right: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            feedback,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[700],
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'About | Contact | Social Media',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class TradeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Trade Type')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[100]!, Colors.orange[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BuyEnergyScreen()),
                  );
                },
                child: Text('Buy Energy', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SellEnergyScreen()),
                  );
                },
                child: Text('Sell Energy', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuyEnergyScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buy Energy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount of Energy (kWh)',
                  hintText: 'Enter energy amount',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.yellow[50],
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price per kWh',
                  hintText: 'Enter price in rupees',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.yellow[50],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                final amount = _amountController.text;
                final price = _priceController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Purchased $amount kWh at ₹$price/kWh')),
                );
              },
              child: Text('Confirm Purchase', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class SellEnergyScreen extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sell Energy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount of Energy (kWh)',
                  hintText: 'Enter energy amount',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.yellow[50],
                ),
              ),
            ),
            SizedBox(height: 20),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price per kWh',
                  hintText: 'Enter price in rupees',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.yellow[50],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                final amount = _amountController.text;
                final price = _priceController.text;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Sold $amount kWh at ₹$price/kWh')),
                );
              },
              child: Text('Confirm Sale', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
