import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {

  String username = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  // AMBIL DATA USER
  void getData() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    setState(() {

      username =
          prefs.getString('username') ?? "";

    });
  }

  // FUNCTION LOGOUT
  void logout() async {

    SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();

    Navigator.pushReplacementNamed(
      context,
      '/',
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Dashboard'),
      ),

      body: Center(

        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Text(
              "Hallo, $username",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Login Berhasil",
            ),

            SizedBox(height: 20),

            ElevatedButton(

              child: Text('Logout'),

              onPressed: logout,

            ),

          ],
        ),
      ),
    );
  }
}