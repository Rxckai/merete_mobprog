import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import 'newsfeed_screen.dart';

// HomeScreen provides the main app bar and bottom navigation.
// It displays the newsfeed or notifications based on the selected tab.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Stores the currently selected bottom navigation item.
  int _selectedIndex = 0;

  // Widgets managed by IndexedStack so the selected page remains active.
  static const List<Widget> _pages = <Widget>[
    NewsFeedScreen(),
    Center(child: Text('Notifications')),
  ];

  // Updates the selected tab and rebuilds the screen.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold creates the standard app layout with an app bar and navigation.
    return Scaffold(
      appBar: AppBar(
        // Displays the Facebook-style app name in the primary app color.
        title: Text(
          'facebook',
          style: TextStyle(
            color: AppColors.facebookBlue,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // IndexedStack shows only the page at the current navigation index.
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        // Defines the items available in the bottom navigation bar.
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.facebookBlue,
        onTap: _onItemTapped,
      ),
    );
  }
}
