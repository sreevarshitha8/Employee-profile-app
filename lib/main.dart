import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF244B70),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF243B53),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const EmployeeProfilePage(),
    );
  }
}

class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({super.key});

  @override
  State<EmployeeProfilePage> createState() =>
      _EmployeeProfilePageState();
}

class _EmployeeProfilePageState
    extends State<EmployeeProfilePage>
    with SingleTickerProviderStateMixin {
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

  List<dynamic> apiUsers = [];
  bool isLoading = false;
  String? apiError;

  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    designationController.dispose();
    super.dispose();
  }

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

  // EXPERIMENT 9: FETCH DATA FROM REST API
  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      apiError = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> decodedData =
            jsonDecode(response.body) as List<dynamic>;

        if (!mounted) return;

        setState(() {
          apiUsers = decodedData;
          isLoading = false;
        });
      } else {
        throw Exception(
          'Server returned status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        apiError = 'Unable to fetch data. Check your internet connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
      ),
      body: Stack(
        children: [
          // PROFESSIONAL DESK BACKGROUND
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.30),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 550,
                  ),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xF7FFFFFF),
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.18),
                              blurRadius: 22,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              const CircleAvatar(
                                radius: 43,
                                backgroundColor: Color(0xFFDCE8F3),
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                  color: Color(0xFF244B70),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                employeeName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF243B53),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                designation,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF486581),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 26),
                              const Text(
                                'Employee Information',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF243B53),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // EMPLOYEE NAME
                              TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  labelText: 'Employee Name',
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Enter employee name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              // EMAIL
                              TextFormField(
                                controller: emailController,
                                keyboardType:
                                    TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      !RegExp(
                                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                      ).hasMatch(value.trim())) {
                                    return 'Enter a valid email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              // PHONE
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone_outlined),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      !RegExp(r'^[0-9]{10}$')
                                          .hasMatch(value.trim())) {
                                    return 'Enter a 10-digit phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),

                              // DESIGNATION
                              TextFormField(
                                controller: designationController,
                                decoration: const InputDecoration(
                                  labelText: 'Designation',
                                  prefixIcon: Icon(Icons.work_outline),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Enter designation';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),

                              ElevatedButton(
                                onPressed: saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF244B70),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text('Save Profile'),
                              ),

                              OutlinedButton(
                                onPressed: restoreProfile,
                                child: const Text('Restore Original'),
                              ),

                              if (isSaved)
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Profile saved successfully.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 8),

                              // EXPERIMENT 9 API SECTION
                              const Text(
                                'Employee Directory (REST API)',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF243B53),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Fetch sample user records from an online REST API.',
                                style: TextStyle(
                                  color: Color(0xFF486581),
                                ),
                              ),
                              const SizedBox(height: 12),

                              ElevatedButton(
                                onPressed:
                                    isLoading ? null : fetchUsers,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF397D83),
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text('Fetch API Data'),
                              ),

                              const SizedBox(height: 12),

                              if (isLoading)
                                const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),

                              if (apiError != null)
                                Column(
                                  children: [
                                    Text(
                                      apiError!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: fetchUsers,
                                      child: const Text('Try Again'),
                                    ),
                                  ],
                                ),

                              if (apiUsers.isNotEmpty)
                                SizedBox(
                                  height: 350,
                                  child: ListView.builder(
                                    itemCount: apiUsers.length,
                                    itemBuilder: (context, index) {
                                      final user =
                                          apiUsers[index]
                                              as Map<String, dynamic>;

                                      return Card(
                                        margin:
                                            const EdgeInsets.symmetric(
                                          vertical: 6,
                                        ),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                const Color(0xFFDCE8F3),
                                            child: Text(
                                              user['id'].toString(),
                                            ),
                                          ),
                                          title: Text(
                                            user['name'].toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${user['email']}\n'
                                            '${user['company']['name']}',
                                          ),
                                          isThreeLine: true,
                                        ),
                                      );
                                    },
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
            ),
          ),
        ],
      ),
    );
  }
}