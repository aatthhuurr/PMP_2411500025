import 'package:flutter/material.dart';
import 'DashboardPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(
                height: 200,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 24),

              // Tombol Login
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Login ditekan");
                  },
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
