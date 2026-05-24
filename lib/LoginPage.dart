import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  // CHECK AUTO LOGIN
  void checkLogin() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    bool isLogin =
        prefs.getBool('isLogin') ?? false;

    if (isLogin) {

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );

    }
  }

  // FUNCTION LOGIN
  void login() async {

    String username =
        usernameController.text;

    String password =
        passwordController.text;

    // VALIDASI LOGIN
    if (username == "2411500025" &&
        password == "12345") {

      SharedPreferences prefs =
          await SharedPreferences.getInstance();

      if (rememberMe) {

        await prefs.setBool(
          'isLogin',
          true,
        );

        await prefs.setString(
          'username',
          username,
        );

      }

      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
      );

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            "Username atau Password salah",
          ),
        ),

      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(

        padding: EdgeInsets.all(20.0),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            SizedBox(height: 100),

            Center(
              child: Text(
                "Login Page",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 80),

            TextField(
              controller: usernameController,

              decoration: InputDecoration(
                hintText: "Masukan username",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 16),

            TextField(
              controller: passwordController,
              obscureText: true,

              decoration: InputDecoration(
                hintText: "Masukan password",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 10),

            Row(

              children: [

                Checkbox(

                  value: rememberMe,

                  onChanged: (value) {

                    setState(() {

                      rememberMe = value!;

                    });

                  },

                ),

                Text("Remember Me"),

              ],
            ),

            SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),

                onPressed: login,

                child: Text("Login"),

              ),
            ),

          ],
        ),
      ),
    );
  }
}