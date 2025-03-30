import 'package:casemet/screens/HomeScreen/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class BottomNaviagtion extends StatefulWidget {
  const BottomNaviagtion({
    super.key,
  });

  @override
  State<BottomNaviagtion> createState() => _BottomNaviagtionState();
}

class _BottomNaviagtionState extends State<BottomNaviagtion> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white.withOpacity(0.8),
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feed),
          label: 'Feeds',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            break;
          case 1:
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => const FeedsPage()),
            // );
            break;
          case 2:
            // Add search functionality here
            break;
          case 3:
            Navigator.pushNamed(
              context,
              '/notification',
            );
            break;
          case 4:
            Navigator.pushNamed(context, '/profile');

            break;
        }
      },
    );
  }
}
