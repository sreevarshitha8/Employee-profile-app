import 'package:flutter/material.dart';

void main() {
  runApp(const EmployeeApp());
}

// APP THEME
class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Profile',

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),

      routes: {
        '/details': (context) => const EmployeeDetailsPage(),
      },

      home: const EmployeeProfilePage(),
    );
  }
}

// EMPLOYEE PROFILE PAGE
class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({super.key});

  @override
  State<EmployeeProfilePage> createState() =>
      _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  String employeeName = 'SREE VARSHITHA';
  String designation = 'Software Engineer';
  String department = 'CSE';

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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: EmployeeCard(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 65,
                      backgroundColor: Color(0xFFE0E7FF),
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      employeeName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      designation,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: Colors.indigo),
                    ),

                    const SizedBox(height: 24),

                    EmployeeInfoRow(
                      icon: Icons.badge,
                      label: 'Employee ID',
                      value: 'EMP101',
                    ),

                    EmployeeInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'employee@gmail.com',
                    ),

                    EmployeeInfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: '9876543210',
                    ),

                    EmployeeInfoRow(
                      icon: Icons.business,
                      label: 'Department',
                      value: department,
                    ),

                    const SizedBox(height: 24),

                    CustomButton(
                      text: isUpdated
                          ? 'Restore Profile'
                          : 'Update Profile',
                      icon: isUpdated ? Icons.restore : Icons.edit,
                      onPressed: updateProfile,
                    ),

                    const SizedBox(height: 12),

                    CustomButton(
                      text: 'View Details',
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetailsPage(
                              name: employeeName,
                              designation: designation,
                              department: department,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    CustomButton(
                      text: 'Open Named Route',
                      icon: Icons.open_in_new,
                      onPressed: () {
                        Navigator.pushNamed(context, '/details');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// EMPLOYEE DETAILS PAGE
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

      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: EmployeeCard(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xFFE0E7FF),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      'Employee Details',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 24),

                    EmployeeInfoRow(
                      icon: Icons.person,
                      label: 'Name',
                      value: name,
                    ),

                    EmployeeInfoRow(
                      icon: Icons.badge,
                      label: 'Employee ID',
                      value: 'EMP101',
                    ),

                    EmployeeInfoRow(
                      icon: Icons.work,
                      label: 'Designation',
                      value: designation,
                    ),

                    EmployeeInfoRow(
                      icon: Icons.business,
                      label: 'Department',
                      value: department,
                    ),

                    EmployeeInfoRow(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'employee@gmail.com',
                    ),

                    EmployeeInfoRow(
                      icon: Icons.phone,
                      label: 'Phone',
                      value: '9876543210',
                    ),

                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Back to Profile',
                      icon: Icons.arrow_back,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// REUSABLE EMPLOYEE INFORMATION ROW
class EmployeeInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const EmployeeInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// REUSABLE CARD WIDGET
class EmployeeCard extends StatelessWidget {
  final Widget child;

  const EmployeeCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

// REUSABLE BUTTON WIDGET
class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}