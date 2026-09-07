import 'package:flutter/material.dart';

void main() {
  runApp(const EmployeeProfileApp());
}

class EmployeeProfileApp extends StatelessWidget {
  const EmployeeProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Profile App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Profile'),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Sree Varshitha',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Software Engineer',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.badge),
                    SizedBox(width: 10),
                    Text('Employee ID: EMP101'),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email),
                    SizedBox(width: 10),
                    Text('employee@gmail.com'),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone),
                    SizedBox(width: 10),
                    Text('9876543210'),
                  ],
                ),

                const SizedBox(height: 25),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}