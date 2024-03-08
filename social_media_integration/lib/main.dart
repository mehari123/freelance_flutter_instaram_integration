import 'package:flutter/material.dart';
import 'package:insta_login/insta_login.dart';
import 'package:insta_login/insta_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:social_media_integration/login.dart';
import 'package:social_media_integration/show_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      title: 'Instagram UI',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   bool isLoggedIn = false;
   String token = '', userid = '', username = '',displayName = '';

  void updateLoginStatus(bool status) {
    setState(() {
      isLoggedIn = status;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Freelance Test App')),
      body: Center(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: isLoggedIn
                  ? ShowProfile()
                  : Login(updateLoginStatus),
                  ),
                  ),
    );
  }
}
