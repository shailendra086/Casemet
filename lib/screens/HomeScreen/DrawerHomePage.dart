import 'package:casemet/provider/theme.dart';
import 'package:casemet/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DrawerHomePage extends StatefulWidget {
  const DrawerHomePage({super.key});

  @override
  State<DrawerHomePage> createState() => _DrawerHomePageState();
}

class _DrawerHomePageState extends State<DrawerHomePage> {
  final List<Map<String, dynamic>> drawerItems = [
    {'icon': Icons.person, 'title': 'Profile'},
    {'icon': Icons.description_outlined, 'title': 'Blog'},
    {'icon': Icons.person, 'title': 'About Us'},
    {'icon': Icons.person, 'title': 'Contact Us'},
    {'icon': Icons.settings, 'title': 'Settings'},
    {'icon': Icons.privacy_tip, 'title': 'Privacy Policies'},
    {'icon': Icons.payment, 'title': 'Payments'},
    {'icon': Icons.work, 'title': 'Services'},
    {'icon': Icons.gavel, 'title': 'Terms and Conditions'},
    {'icon': Icons.help, 'title': 'Help and Support'},
    {'icon': Icons.logout, 'title': 'Logout'},
  ];

  final Authservices _authService = Authservices();
  Map<String, dynamic> user = {};
  bool isLoading = true;
  bool status = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var userData = await _authService.getUserData();
    if (userData != null) {
      setState(() {
        user = userData;
        isLoading = false;
      });
    } else {
      // _redirectToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeProviderState>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple, // Matching drawer color
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage(
                      user['profileImage'] ?? 'assets/profile/profile.jpg'),
                ),
                const SizedBox(height: 10),
                Text(
                  user['name'] ?? 'Online Kachehari',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ...drawerItems.map((item) {
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 20),
              visualDensity: VisualDensity.comfortable,
              textColor: themeData.isDarkMode ? Colors.white : Colors.black,
              minTileHeight: 5,
              leading: Icon(item['icon'], color: Colors.deepPurple),
              title: Text(item['title']),
              onTap: () {
                if (item['title'] == 'Profile') {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => Profile()));
                } else if (item['title'] == 'Blog') {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => TrendingBlogs()));
                } else if (item['title'] == 'About Us') {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => AboutUsScreen()));
                } else if (item['title'] == 'Contact Us') {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const ContactUs()));
                } else if (item['title'] == 'Settings') {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => SettingsPage()));
                } else if (item['title'] == 'Privacy Policies') {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (context) => const Policy()));
                } else if (item['title'] == 'Payments') {
                  // Add navigation to payments page
                } else if (item['title'] == 'Services') {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const ServicesPage()));
                } else if (item['title'] == 'Terms and Conditions') {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const TermsConditions()));
                } else if (item['title'] == 'Help and Support') {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Customersupport()));
                } else if (item['title'] == 'Logout') {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const LoginScreen()));
                }
              },
            );
          }),
        ],
      ),
      backgroundColor: themeData.isDarkMode ? Colors.black : Colors.white,
    );
  }
}
