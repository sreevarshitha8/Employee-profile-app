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

      // Named Route
      routes: {
        '/details': (context) => const EmployeeDetailsPage(),
      },

      home: const EmployeeProfilePage(),
    );
  }
}

// --------------------------------------------------
// EMPLOYEE PROFILE PAGE
// --------------------------------------------------

class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({super.key});

  @override
  State<EmployeeProfilePage> createState() =>
      _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {

  // State variables
  String employeeName = 'SREE VARSHITHA';
  String designation = 'Software Engineer';
  String department = 'CSE';

  // Change employee information
  bool isUpdated = false;

void updateProfile() {
  setState(() {
    if (isUpdated) {
      employeeName = 'SREE VARSHITHA';
      designation = 'Software Engineer';
      department = 'CSE';
      isUpdated = false;
    } else {
      employeeName = 'SREE VARSHITHA';
      designation = 'Senior Software Engineer';
      department = 'Computer Science';
      isUpdated = true;
    }
  });
}

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
                Text(
                  employeeName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Designation
                Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 25),

                // Employee ID
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

                // Email
                const Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 15),
                    Text(
                      'Email: varshitha@gmail.com',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                // Phone
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

                const SizedBox(height: 15),

                // Department
                Row(
                  children: [
                    const Icon(Icons.school),
                    const SizedBox(width: 15),
                    Text(
                      'Department: $department',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Update Profile Button
  
ElevatedButton.icon(
  onPressed: updateProfile,
  icon: Icon(
    isUpdated ? Icons.restore : Icons.edit,
  ),
  label: Text(
    isUpdated ? 'Restore Profile' : 'Update Profile',
  ),
),

                const SizedBox(height: 15),

                // Navigate to Details
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EmployeeDetailsPage(
                              name: employeeName,
                              designation: designation,
                              department: department,
                            ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('View Details'),
                ),

                const SizedBox(height: 15),

                // Named Route
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
// EMPLOYEE DETAILS PAGE
// --------------------------------------------------

class EmployeeDetailsPage extends StatelessWidget {
  final String name;
  final String designation;
  final String department;

  const EmployeeDetailsPage({
    super.key,
    this.name = 'SREE VARSHITHA',
    this.designation = 'Software Engineer',
    this.department = 'CSE',
  });

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

                Text(
                  'Name: $name',
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Employee ID: EMP101',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                Text(
                  'Department: $department',
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                Text(
                  'Designation: $designation',
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Email: varshitha@gmail.com',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Phone: 9876543210',
                  style: TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 30),

                // Back button
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