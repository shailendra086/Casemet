import 'package:casemet/provider/theme.dart';
import 'package:casemet/screens/HomeScreen/Notification.dart';
import 'package:casemet/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final Authservices _authService = Authservices();
  Map<String, dynamic> user = {};
  bool isLoading = true;
  bool status = true;
  bool usertype = true;

  int _selectedIndex = 4;

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
      _redirectToLogin();
    }
  }

  void _redirectToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/onboarding');
    });
  }

  void _logout() async {
    await _authService.signOut();
    _redirectToLogin();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeProviderState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title:
            const Text('User Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user.isEmpty
              ? const Center(child: Text("No user data available"))
              : Container(
                  color: themeData.isDarkMode ? Colors.black : Colors.grey[100],
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // Profile Header
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 60, 4, 213),
                              Color.fromRGBO(37, 6, 105, 1)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      user['profileImage'] ??
                                          'assets/profile/profile.jpg'),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            user['name'] ?? 'User Name',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.verified,
                                            color: Colors.yellowAccent,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.email,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            user['email'] ?? 'N/A',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            user['address'] ?? 'N/A',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const SectionHeader(title: 'Activity & Status'),
                      ProfileItem(
                        icon: Icons.circle,
                        color: Colors.green,
                        title: 'Status',
                        subtitle: status ? 'Online' : 'Offline',
                      ),
                      ProfileItem(
                          icon: Icons.person_pin_rounded,
                          color: Colors.blue,
                          title: 'User Type',
                          subtitle: usertype ? 'CUSTOMER' : 'ADVOCATE',
                          onTap: () {}),
                      const SizedBox(height: 20),
                      const SectionHeader(title: 'Preferences'),
                      ProfileItem(
                        icon: Icons.settings,
                        color: Colors.grey,
                        title: 'Account Settings',
                        subtitle: 'Change password, privacy settings, etc.',
                        onTap: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                      ProfileItem(
                        icon: Icons.language,
                        color: Colors.orange,
                        title: 'Language',
                        subtitle: 'English, Hindi',
                        onTap: () {
                          // Handle language change
                        },
                      ),
                      const SizedBox(height: 20),
                      const SectionHeader(title: 'Social Profiles'),
                      ProfileItem(
                        icon: FontAwesomeIcons.instagram,
                        color: Colors.red,
                        title: 'Instagram',
                        subtitle: user['instagram'] ?? 'N/A',
                        onTap: () {},
                      ),
                      ProfileItem(
                        icon: FontAwesomeIcons.linkedin,
                        color: Colors.blue,
                        title: 'LinkedIn',
                        subtitle: user['linkedin'] ?? 'N/A',
                        onTap: () {},
                      ),
                      ProfileItem(
                        icon: FontAwesomeIcons.facebook,
                        color: Colors.blue,
                        title: 'LinkedIn',
                        subtitle: user['linkedin'] ?? 'N/A',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const FeedsPage()));
            // break;
            case 3:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
              break;
            case 4:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserProfile()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feeds'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Section Header Widget
class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Profile Item Widget
class ProfileItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeProviderState>(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
      title: Text(title,
          style: TextStyle(
              fontSize: 16,
              color: themeData.isDarkMode ? Colors.white : Colors.black)),
      subtitle: Text(subtitle,
          style: TextStyle(
              fontSize: 14,
              color: themeData.isDarkMode ? Colors.white70 : Colors.black54)),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: themeData.isDarkMode ? Colors.deepPurpleAccent : Colors.black,
      ),
      onTap: onTap,
    );
  }
}
