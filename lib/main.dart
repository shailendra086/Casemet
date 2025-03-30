import 'package:casemet/provider/theme.dart';
import 'package:casemet/screens/HomeScreen/HomeScreen.dart';
import 'package:casemet/screens/HomeScreen/LiveAdvoates.dart';
import 'package:casemet/screens/HomeScreen/LiveWakeels.dart';
import 'package:casemet/screens/HomeScreen/TopAdvocates.dart';
import 'package:casemet/screens/auth/CasemetOnboarding.dart';
import 'package:casemet/screens/auth/ForgotScreen.dart';
import 'package:casemet/screens/auth/LoginScreen.dart';
import 'package:casemet/screens/HomeScreen/Notification.dart';

import 'package:casemet/screens/auth/SplashScreen.dart';

import 'package:casemet/services/notification_service.dart';
import 'package:casemet/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure proper binding for Firebase
  await Firebase.initializeApp(); // Initialize Firebase

  // init Notification
  NotificationService().initNotification();
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeProviderState(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const CaseMetLoginScreen(),
        '/wrapper': (context) => const Wrapper(),
        '/login': (context) => const LoginScreen(),
        '/notification': (context) => const NotificationPage(),
        '/mobileverfication': (context) => const Mobileverfication (),
        '/forget': (context) => const ForgotScreen(),
        '/home': (context) => const HomeScreen(),
        '/topadvocate': (context) => const TopAdvocates(),
        '/liveadvocates': (context) => const LiveAdvocates(),
        '/live': (context) => const LiveWakeels(),
        '/profile': (context) => const UserProfile(),
        '/setting': (context) => const SettingsPage(),
        // '/mobile': (context) => const MobileAuthScreen(),
      },
    );
  }
}
