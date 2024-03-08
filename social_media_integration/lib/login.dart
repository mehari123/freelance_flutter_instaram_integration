import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:insta_login/insta_view.dart';
import 'package:insta_login/insta_view.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  final Function updateLoginStatus;

  Login(this.updateLoginStatus);
  @override
  _LoginState createState() => _LoginState();
 
  
}

class _LoginState extends State<Login> {

  late SharedPreferences prefs;

  @override
  void initState() {
    
    super.initState();
    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((instance) => prefs = instance);
    // prefs.remove('access_token');
  }
  String dropdownValue = 'English';
  String token = '', userid = '', username = '', displayName = '';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  int buttonColor = 0xff26A9FF;

  bool inputTextNotNull = false;

  @override
  Widget build(BuildContext context) {
    double deviseWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 150,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white70,
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 10,
                      style: TextStyle(color: Colors.black54),
                      underline: Container(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue ?? '';
                        });
                      },
                      items: <String>['English', 'Amharic', 'Italian', 'French']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Text(
                          "Social media integration and selected features",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors
                                .blue, // Choose a color that suits your app's theme
                            fontWeight: FontWeight.bold, // Makes the text bold
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .05,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: usernameController,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            enabled: false,
                            decoration: InputDecoration.collapsed(
                              hintText: 'username',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    Container(
                      width: deviseWidth * .90,
                      height: deviseWidth * .14,
                      decoration: BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextField(
                            onChanged: (text) {
                              setState(() {
                                if (usernameController.text.length >= 2 &&
                                    passwordController.text.length >= 2) {
                                  inputTextNotNull = true;
                                } else {
                                  inputTextNotNull = false;
                                }
                              });
                            },
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                            enabled:
                                false, // Set to false to disable the text field
                            decoration: InputDecoration.collapsed(
                              hintText: 'Password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .04,
                    ),
                    IgnorePointer(
                      child: Container(
                        width: deviseWidth * .90,
                        height: deviseWidth * .14,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 125, 133, 137),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: deviseWidth * .040,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: deviseWidth * .035,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Forgot your login details? ',
                          style: TextStyle(
                            fontSize: deviseWidth * .035,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Get help');
                          },
                          child: Text(
                            'Get help',
                            style: TextStyle(
                              fontSize: deviseWidth * .035,
                              color: Color(0xff002588),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviseWidth * .040,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: deviseWidth * .30,
                          color: Color(0xffA2A2A2),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            fontSize: deviseWidth * .030,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 1,
                          width: deviseWidth * .40,
                          color: Color(0xffA2A2A2),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviseWidth * .06,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login with Instagram',
                          style: TextStyle(
                            color: Color(0xff1877f2),
                            fontSize: deviseWidth * .060,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return InstaView(
                                    instaAppId: '756765859880791',
                                    instaAppSecret:
                                        'c345770ca796a04840567346eb7e1551',
                                    redirectUrl: 'https://localhost:5001/',
                                    onComplete: (_token, _userid, _username) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback(
                                        (timeStamp) {
                                        
                                          setState(()  {
                                            token = _token;
                                            userid = _userid;
                                            username = _username;
                                            bool loginStatus =
                                                true; // Set this value based on your login operation
                                            widget
                                                .updateLoginStatus(loginStatus);
                                             
                                                prefs.setString('access_token', token);
                                                prefs.setString('userid', userid);
                                                prefs.setString('username', username);
                                            
                                            // Set the flag to true
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/instagram_logo.jpg',
                            height: deviseWidth * .30,
                            width: deviseWidth * .40,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: deviseWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: deviseWidth,
                        height: 1,
                        color: Color(0xffA2A2A2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: deviseWidth * .040,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('Sing up');
                            },
                            child: Text(
                              'Sing up',
                              style: TextStyle(
                                color: Color(0xff00258B),
                                fontSize: deviseWidth * .040,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
