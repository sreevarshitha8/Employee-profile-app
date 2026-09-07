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
        body: const Center(
          child: Text(
            'Employee Profile App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}