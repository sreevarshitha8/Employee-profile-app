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
      title: 'Employee Profile',
      home: const EmployeeProfilePage(),
    );
  }
}

class EmployeeProfilePage extends StatelessWidget {
  const EmployeeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get screen size using MediaQuery
            double screenWidth = MediaQuery.of(context).size.width;
            double screenHeight = MediaQuery.of(context).size.height;

            // Responsive condition
            bool isLargeScreen = constraints.maxWidth >= 900;

            // Change sizes according to screen
            double imageSize = isLargeScreen ? 200 : 130;
            double padding = isLargeScreen ? 40 : 20;

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  width: isLargeScreen
                      ? screenWidth * 0.70
                      : screenWidth * 0.90,
                  padding: EdgeInsets.all(padding),
                  margin: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [
                      // Profile Picture
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: imageSize / 2,
                            child: Icon(
                              Icons.person,
                              size: imageSize * 0.55,
                            ),
                          ),

                          const Icon(
                            Icons.check_circle,
                            size: 32,
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Employee Name
                      Text(
                        'Sree Varshitha',
                        style: TextStyle(
                          fontSize: isLargeScreen ? 32 : 26,
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

                      // Employee Basic Details
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.badge,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text('EMP101'),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.business,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text('CSE'),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text('Hyderabad'),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Contact Information
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),

                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: Column(
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.email),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    'employee@gmail.com',
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15),

                            Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    '9876543210',
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 15),

                            Row(
                              children: [
                                Icon(Icons.work),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    'Software Development',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Responsive Information
                     // Text(
                       // isLargeScreen
                         //   ? 'Large Screen'
                          //  : 'Small Screen',
                     // ),

                      const SizedBox(height: 8),

                      //Text(
                       // 'Screen: ${screenWidth.toInt()} x ${screenHeight.toInt()}',
                      //),

                      const SizedBox(height: 20),

                      // Edit Button
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}