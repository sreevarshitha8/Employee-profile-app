import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const EmployeeApp());
}

const Color navy = Color(0xFF243B53);
const Color teal = Color(0xFF397D83);

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Profile',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: navy),
        appBarTheme: const AppBarTheme(
          backgroundColor: navy,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      routes: {
        '/api': (context) => const ApiDemoPage(),
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

class _EmployeeProfilePageState extends State<EmployeeProfilePage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final nameController =
      TextEditingController(text: 'Sree Varshitha');
  final emailController =
      TextEditingController(text: 'sree@gmail.com');
  final phoneController =
      TextEditingController(text: '9876543210');
  final professionController =
      TextEditingController(text: 'Software Engineer');

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  String savedName = 'Sree Varshitha';
  String savedEmail = 'sree@gmail.com';
  String savedPhone = '9876543210';
  String savedProfession = 'Software Engineer';

  bool profileSaved = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    professionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        savedName = nameController.text.trim();
        savedEmail = emailController.text.trim();
        savedPhone = phoneController.text.trim();
        savedProfession = professionController.text.trim();
        profileSaved = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile saved successfully!'),
        ),
      );
    }
  }

  void restoreOriginal() {
    setState(() {
      nameController.text = 'Sree Varshitha';
      emailController.text = 'sree@gmail.com';
      phoneController.text = '9876543210';
      professionController.text = 'Software Engineer';

      savedName = 'Sree Varshitha';
      savedEmail = 'sree@gmail.com';
      savedPhone = '9876543210';
      savedProfession = 'Software Engineer';
      profileSaved = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Original profile restored!'),
      ),
    );
  }

  void viewEmployeeDetails() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmployeeDetailsPage(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          profession: professionController.text.trim(),
          place: 'Hyderabad, Telangana',
          salary: '₹6,00,000 per annum',
          department: 'Computer Science',
          employeeId: 'EMP101',
          experience: '2 years',
        ),
      ),
    );
  }

  Widget profileField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: teal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Profile'),
        actions: [
          IconButton(
            tooltip: 'REST API Demo',
            icon: const Icon(Icons.cloud_download),
            onPressed: () {
              Navigator.pushNamed(context, '/api');
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(color: const Color(0xFFEAF0F4));
            },
          ),
          Container(
            color: Colors.white.withOpacity(0.72),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _animationController,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                    ),
                    child: Card(
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 48,
                                backgroundColor: navy,
                                child: Icon(
                                  Icons.person,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 14),
                              const Text(
                                'Employee Information',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: navy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                profileSaved
                                    ? 'Profile saved'
                                    : 'Edit your profile details below',
                                style: TextStyle(
                                  color: profileSaved
                                      ? Colors.green
                                      : Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 25),

                              profileField(
                                label: 'Full Name',
                                icon: Icons.person_outline,
                                controller: nameController,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Enter your name';
                                  }
                                  return null;
                                },
                              ),

                              profileField(
                                label: 'Email',
                                icon: Icons.email_outlined,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
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

                              profileField(
                                label: 'Phone Number',
                                icon: Icons.phone_outlined,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null ||
                                      !RegExp(r'^[0-9]{10}$')
                                          .hasMatch(value.trim())) {
                                    return 'Enter a 10-digit phone number';
                                  }
                                  return null;
                                },
                              ),

                              profileField(
                                label: 'Profession',
                                icon: Icons.work_outline,
                                controller: professionController,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Enter your profession';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 8),

                              // All three buttons are together.
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: saveProfile,
                                    icon: const Icon(Icons.save),
                                    label: const Text('Save Profile'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: navy,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: restoreOriginal,
                                    icon: const Icon(Icons.restore),
                                    label: const Text('Restore Original'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: viewEmployeeDetails,
                                    icon: const Icon(Icons.badge_outlined),
                                    label: const Text('View Details'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: teal,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 14),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/api');
                                  },
                                  icon: const Icon(Icons.cloud_download),
                                  label: const Text('REST API Demo'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF526D82),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(14),
                                  ),
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

// --------------------------------------------------
// EMPLOYEE DETAILS PAGE
// --------------------------------------------------

class EmployeeDetailsPage extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String profession;
  final String place;
  final String salary;
  final String department;
  final String employeeId;
  final String experience;

  const EmployeeDetailsPage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
    required this.profession,
    required this.place,
    required this.salary,
    required this.department,
    required this.employeeId,
    required this.experience,
  });

  Widget detailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: teal, size: 25),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: navy,
                      child: Icon(
                        Icons.person,
                        size: 52,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: navy,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      profession,
                      style: const TextStyle(
                        fontSize: 16,
                        color: teal,
                      ),
                    ),
                    const SizedBox(height: 24),

                    detailRow(
                      Icons.badge,
                      'Employee ID',
                      employeeId,
                    ),
                    detailRow(
                      Icons.person_outline,
                      'Full Name',
                      name,
                    ),
                    detailRow(
                      Icons.work,
                      'Profession',
                      profession,
                    ),
                    detailRow(
                      Icons.email,
                      'Email Address',
                      email,
                    ),
                    detailRow(
                      Icons.phone,
                      'Phone Number',
                      phone,
                    ),
                    detailRow(
                      Icons.location_on,
                      'Place',
                      place,
                    ),
                    detailRow(
                      Icons.account_balance_wallet,
                      'Salary',
                      salary,
                    ),
                    detailRow(
                      Icons.business,
                      'Department',
                      department,
                    ),
                    detailRow(
                      Icons.timeline,
                      'Experience',
                      experience,
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back to Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: navy,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(14),
                        ),
                      ),
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

// --------------------------------------------------
// REST API PAGE - FETCHES MULTIPLE PEOPLE
// --------------------------------------------------

class ApiDemoPage extends StatefulWidget {
  const ApiDemoPage({super.key});

  @override
  State<ApiDemoPage> createState() => _ApiDemoPageState();
}

class _ApiDemoPageState extends State<ApiDemoPage> {
  List<dynamic> users = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        if (!mounted) return;

        setState(() {
          users = data;
          isLoading = false;
        });
      } else {
        throw Exception(
          'Server returned status ${response.statusCode}',
        );
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Could not load people. Check your internet connection.';
      });
    }
  }

  Widget userInfo(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: teal),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API - People'),
        actions: [
          IconButton(
            tooltip: 'Refresh people',
            onPressed: fetchUsers,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15),
                  Text('Loading people from REST API...'),
                ],
              ),
            )
          : errorMessage.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.cloud_off,
                          size: 55,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton.icon(
                          onPressed: fetchUsers,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchUsers,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        'People Details (${users.length})',
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: navy,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'These sample people are fetched from a REST API.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 14),

                      ...users.map((user) {
                        final address =
                            user['address'] as Map<String, dynamic>? ?? {};
                        final company =
                            user['company'] as Map<String, dynamic>? ?? {};

                        final geo =
                            address['geo'] as Map<String, dynamic>? ?? {};

                        final location = [
                          address['city'] ?? '',
                          address['street'] ?? '',
                        ].where((part) => part.toString().isNotEmpty).join(', ');

                        return Card(
                          margin: const EdgeInsets.only(bottom: 14),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: navy,
                                      child: Text(
                                        (user['name'] ?? '?')
                                            .toString()
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        user['name']?.toString() ?? 'Unknown',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                userInfo(
                                  Icons.alternate_email,
                                  'Username',
                                  user['username']?.toString() ?? 'N/A',
                                ),
                                userInfo(
                                  Icons.email_outlined,
                                  'Email',
                                  user['email']?.toString() ?? 'N/A',
                                ),
                                userInfo(
                                  Icons.phone_outlined,
                                  'Phone',
                                  user['phone']?.toString() ?? 'N/A',
                                ),
                                userInfo(
                                  Icons.language,
                                  'Website',
                                  user['website']?.toString() ?? 'N/A',
                                ),
                                userInfo(
                                  Icons.business,
                                  'Company',
                                  company['name']?.toString() ?? 'N/A',
                                ),
                                userInfo(
                                  Icons.location_on_outlined,
                                  'Address',
                                  location.isEmpty ? 'N/A' : location,
                                ),
                                userInfo(
                                  Icons.map_outlined,
                                  'Coordinates',
                                  '${geo['lat'] ?? 'N/A'}, ${geo['lng'] ?? 'N/A'}',
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
    );
  }
}