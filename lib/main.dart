import 'package:flutter/material.dart';

void main() {
  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Profile',

      // Named Routes
      routes: {
        '/details': (context) => const EmployeeDetailsPage(),
      },

      home: const EmployeeProfilePage(),
    );
  }
}

// --------------------------------------------------
// EMPLOYEE PROFILE SCREEN
// --------------------------------------------------

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [

                // Profile Picture
                const CircleAvatar(
                  radius: 70,
                  child: Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),

                const SizedBox(height: 20),

                // Employee Name
                const Text(
                  'SREE VARSHITHA',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Designation
                const Text(
                  'Software Engineer',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 25),

                // Employee Information
                const Row(
                  children: [
                    Icon(Icons.badge),
                    SizedBox(width: 15),
                    Text(
                      'Employee ID: EMP101',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                const Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 15),
                    Text(
                      'Email:varshitha@gmail.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                const Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 15),
                    Text(
                      'Phone: 9876543210',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Navigator.push()
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const EmployeeDetailsPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View Details'),
                ),

                const SizedBox(height: 15),

                // Navigator.pushNamed()
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Named Route'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------
// EMPLOYEE DETAILS SCREEN
// --------------------------------------------------

class EmployeeDetailsPage extends StatelessWidget {
  const EmployeeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Column(
              children: [

                // Employee Icon
                const CircleAvatar(
                  radius: 60,
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Employee Details',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Name: sree varshitha',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Employee ID: EMP101',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Department: CSE',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Designation: Software Engineer',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Email: varshitha @gmail.com',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Phone: 9876543210',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 30),

                // Navigator.pop()
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}