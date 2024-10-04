import 'package:flutter/material.dart';

void main() {
  runApp(SolarEnergyTradingApp());
}

class SolarEnergyTradingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P2P Solar Energy Trading Platform',
      theme: ThemeData(
        primaryColor: Colors.yellow[700],
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeveloperInfoScreen()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
            child: Text(
              'Solar Energy Trading',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[700],
              ),
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.comment_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CommunityScreen()),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white70, Colors.white70],
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
                HeroSection(),
                TradingCardsSection(),
                UserFeedbackSection(),
              ],
            ),
          ),
          SwipeablePanel(),
        ],
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

class SwipeablePanel extends StatefulWidget {
  @override
  _SwipeablePanelState createState() => _SwipeablePanelState();
}

class _SwipeablePanelState extends State<SwipeablePanel> {
  double _panelHeight = 0.0;

  void _togglePanel() {
    setState(() {
      _panelHeight = _panelHeight == 0.0 ? 300.0 : 0.0; // Toggle between 0 and 300
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          _togglePanel(); // Swipe left to open the panel
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _panelHeight,
        color: Colors.blueGrey[200],
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'User Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
          ],
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow[700]!, Colors.orange[400]!],
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.yellow[700],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TradeSelectionScreen()),
                );
              },
              child: Text('Start Trading Now', style: TextStyle(fontSize: 18)),
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
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        offers[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {
                          // Handle trade action
                        },
                        child: Text('Trade Now'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

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
      color: Colors.yellow[700],
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

