import 'dart:developer';
import 'package:akpa/service/api_service.dart';
import 'package:akpa/service/store_service.dart';
import 'package:akpa/view/bottom_bar/bottom_bar.dart';
import 'package:akpa/view/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final StoreService storeService = StoreService();

  bool isLoading = false;
  bool signInObscureText = true;

  void signInObscureChange() {
    setState(() {
      signInObscureText = !signInObscureText;
    });
  }

  Future<void> attemptLogin() async {
    setState(() {
      isLoading = true;
    });

    String username = usernameController.text;
    String password = passwordController.text;

    final loginResponse = await apiService.login(username, password);

    setState(() {
      isLoading = false;
    });

    if (loginResponse != null) {
      // Store user credentials
      await storeService.setKeys('username', username);
      await storeService.setKeys('password', password);

      // Update device token on login
      await apiService.updateDeviceToken(username);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid username or password, please try again'),
        ),
      );
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms & Conditions'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions content goes here...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/akpalogo.jpeg'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: usernameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.black),
                    suffixIcon:
                        Icon(Icons.check_circle_outlined, color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter User Name";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: signInObscureText,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.black),
                    suffixIcon: IconButton(
                      onPressed: signInObscureChange,
                      icon: Icon(
                        signInObscureText
                            ? Icons.visibility_off
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await attemptLogin();
                          } catch (e) {
                            log("validation error: $e");
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account? ',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  // GestureDetector(
                  //   onTap: () async {
                  //     final url = Uri.parse(
                  //         'https://lifelinekeralatrust.com/member/auth/register');
                  //     if (await canLaunchUrl(url)) {
                  //       await launchUrl(url);
                  //       log('URL opened: $url');
                  //     } else {
                  //       log('Could not launch URL');
                  //     }
                  //   },
                  //   child: const Text(
                  //     'Register now',
                  //     style: TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black,
                  //         decoration: TextDecoration.underline),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'By signing up, you agree with our ',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () => _showTermsAndConditions(context),
                    child: const Text(
                      'Terms & Conditions',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
