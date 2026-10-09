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

// REUSABLE DESK-PHOTO BACKGROUND
class DeskBackground extends StatelessWidget {
  final Widget child;

  const DeskBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/background.jpg',
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),

        // Light overlay keeps the form readable.
        Container(
          color: Colors.white.withOpacity(0.24),
        ),

        SafeArea(child: child),
      ],
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

  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    // Animations start automatically when the page opens.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
          backgroundColor: Color(0xFF246B55),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: DeskBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: FadeTransition(
                opacity: _fade,
                child: SlideTransition(
                  position: _slide,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: const Color(0xF7FFFFFF),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF20364D)
                              .withOpacity(0.20),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
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

                          const SizedBox(height: 13),

                          AnimatedSwitcher(
                            duration: const Duration(
                              milliseconds: 350,
                            ),
                            child: Text(
                              employeeName,
                              key: ValueKey(employeeName),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF243B53),
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          AnimatedSwitcher(
                            duration: const Duration(
                              milliseconds: 350,
                            ),
                            child: Text(
                              designation,
                              key: ValueKey(designation),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF486581),
                              ),
                            ),
                          ),

                          const SizedBox(height: 27),

                          const Text(
                            'Employee Information',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF243B53),
                            ),
                          ),

                          const SizedBox(height: 18),

                          _field(
                            controller: nameController,
                            label: 'Employee Name',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Enter employee name';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          _field(
                            controller: emailController,
                            label: 'Email Address',
                            icon: Icons.email_outlined,
                            keyboardType:
                                TextInputType.emailAddress,
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

                          const SizedBox(height: 16),

                          _field(
                            controller: phoneController,
                            label: 'Phone Number',
                            icon: Icons.phone_outlined,
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

                          const SizedBox(height: 16),

                          _field(
                            controller: designationController,
                            label: 'Designation',
                            icon: Icons.work_outline,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty) {
                                return 'Enter designation';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF244B70),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Save Profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 11),

                          OutlinedButton(
                            onPressed: restoreProfile,
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  const Color(0xFF244B70),
                              side: const BorderSide(
                                color: Color(0xFF8AA6C1),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Restore Original'),
                          ),

                          const SizedBox(height: 11),

                          ElevatedButton(
                            onPressed: () {
                              if (!isSaved) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please save the profile first.',
                                    ),
                                  ),
                                );
                                return;
                              }

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
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF397D83),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('View Saved Details'),
                          ),

                          AnimatedSize(
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            curve: Curves.easeInOut,
                            child: isSaved
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 14),
                                    child: Text(
                                      'Profile saved successfully.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xFF246B55),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
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
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF486581),
        ),
        filled: true,
        fillColor: const Color(0xFFF7FAFC),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFBCCCDC),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFBCCCDC),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF397D83),
            width: 2,
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
      appBar: AppBar(
        title: const Text('Employee Details'),
      ),
      body: DeskBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: FadeInDetails(
                child: Container(
                  padding: const EdgeInsets.all(25),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      const SizedBox(height: 15),
                      Text(
                        name,
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
                        style: const TextStyle(
                          color: Color(0xFF486581),
                          fontSize: 16,
                        ),
                      ),
                      const Divider(height: 32),
                      _detail('Employee ID', 'EMP101'),
                      _detail('Email', email),
                      _detail('Phone', phone),
                      _detail('Designation', designation),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF244B70),
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 14,
                            ),
                          ),
                          child: const Text('Back to Profile'),
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

  Widget _detail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF334E68),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF102A43),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// REUSABLE FADE AND SLIDE ANIMATION FOR DETAILS
class FadeInDetails extends StatefulWidget {
  final Widget child;

  const FadeInDetails({
    super.key,
    required this.child,
  });

  @override
  State<FadeInDetails> createState() => _FadeInDetailsState();
}

class _FadeInDetailsState extends State<FadeInDetails>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}