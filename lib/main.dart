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
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const EmployeeProfilePage(),
    );
  }
}

// BACKGROUND IMAGE
class BackgroundLayout extends StatelessWidget {
  final Widget child;

  const BackgroundLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Colourful gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF89F7FE),
                Color(0xFF66A6FF),
                Color(0xFFB57BEE),
                Color(0xFFFFC3E6),
              ],
            ),
          ),
        ),

        // Decorative circles
        Positioned(
          top: -70,
          right: -45,
          child: _backgroundCircle(
            size: 220,
            color: Colors.white.withOpacity(0.20),
          ),
        ),

        Positioned(
          bottom: 40,
          left: -65,
          child: _backgroundCircle(
            size: 180,
            color: Colors.purple.withOpacity(0.12),
          ),
        ),

        Positioned(
          top: 250,
          right: -35,
          child: _backgroundCircle(
            size: 100,
            color: Colors.pink.withOpacity(0.15),
          ),
        ),

        // Employee profile content
        SafeArea(child: child),
      ],
    );
  }

  Widget _backgroundCircle({
    required double size,
    required Color color,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}


// EMPLOYEE PROFILE FORM
class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({super.key});

  @override
  State<EmployeeProfilePage> createState() =>
      _EmployeeProfilePageState();
}

class _EmployeeProfilePageState
    extends State<EmployeeProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController(text: 'Sree Varshitha');
  final emailController =
      TextEditingController(text: 'sree@gmail.com');
  final phoneController =
      TextEditingController(text: '9876543210');
  final designationController =
      TextEditingController(text: 'Software Engineer');

  String employeeName = 'Sree Varshitha';
  String email = 'sree@gmail.com';
  String phone = '9876543210';
  String designation = 'Software Engineer';

  bool isSaved = false;

  // VALIDATE AND SAVE PROFILE
  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        employeeName = nameController.text.trim();
        email = emailController.text.trim();
        phone = phoneController.text.trim();
        designation = designationController.text.trim();
        isSaved = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
         content: Text('Profile saved successfully!'),
       ),
      );
   }
 }
 

  // RESTORE ORIGINAL PROFILE
  void restoreProfile() {
    setState(() {
      nameController.text = 'Sree Varshitha';
      emailController.text = 'sree@gmail.com';
      phoneController.text = '9876543210';
      designationController.text = 'Software Engineer';

      employeeName = 'Sree Varshitha';
      email = 'sree@gmail.com';
      phone = '9876543210';
      designation = 'Software Engineer';

      isSaved = false;
    });

    _formKey.currentState?.reset();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    designationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: BackgroundLayout(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 550),
              child: Card(
                color: Colors.white.withOpacity(0.96),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xFFE0E7FF),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.indigo,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          employeeName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          designation,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.indigo,
                          ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                          'Edit Employee Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        // NAME FIELD
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Employee Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter employee name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // EMAIL FIELD
                        TextFormField(
                          controller: emailController,
                          keyboardType:
                              TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter email';
                            }

                            if (!RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            ).hasMatch(value.trim())) {
                              return 'Enter a valid email';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // PHONE FIELD
                        TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            counterText: '',
                          ),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^[0-9]{10}$')
                                    .hasMatch(value.trim())) {
                              return 'Enter a valid 10-digit number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // DESIGNATION FIELD
                        TextFormField(
                          controller: designationController,
                          decoration: const InputDecoration(
                            labelText: 'Designation',
                            prefixIcon: Icon(Icons.work),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Please enter designation';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        ElevatedButton.icon(
                          onPressed: saveProfile,
                          icon: const Icon(Icons.save),
                          label: const Text('Save Profile'),
                        ),

                        const SizedBox(height: 10),

                        OutlinedButton.icon(
                          onPressed: restoreProfile,
                          icon: const Icon(Icons.restore),
                          label: const Text('Restore Original'),
                        ),

                        const SizedBox(height: 12),

                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeDetailsPage(
                                  name: employeeName,
                                  email: email,
                                  phone: phone,
                                  designation: designation,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('View Saved Details'),
                        ),

                        if (isSaved) ...[
                          const SizedBox(height: 12),
                          const Text(
                            'Profile saved successfully.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// EMPLOYEE DETAILS SCREEN
class EmployeeDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String designation;

  const EmployeeDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.designation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: BackgroundLayout(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Card(
                color: Colors.white.withOpacity(0.96),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xFFE0E7FF),
                        child: Icon(
                          Icons.person,
                          size: 65,
                          color: Colors.indigo,
                        ),
                      ),

                      const SizedBox(height: 18),

                      const Text(
                        'Employee Details',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 22),

                      DetailRow(
                        label: 'Employee ID',
                        value: 'EMP101',
                      ),
                      DetailRow(label: 'Name', value: name),
                      DetailRow(
                        label: 'Designation',
                        value: designation,
                      ),
                      DetailRow(label: 'Email', value: email),
                      DetailRow(label: 'Phone', value: phone),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Back to Profile'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// REUSABLE DETAIL ROW
class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}