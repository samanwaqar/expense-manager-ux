import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SignupController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1115),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 40),

              const Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Start tracking your expenses smarter",
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 40),

              _field(nameController, "Name", Icons.person_outline),
              const SizedBox(height: 15),
              _field(emailController, "Email", Icons.email_outlined),
              const SizedBox(height: 15),

              _field(
                passwordController,
                "Password",
                Icons.lock_outline,
                obscure: isHidden,
                suffix: IconButton(
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

              controller.isLoading
                  ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlueAccent,
                ),
              )
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    bool success = await controller.signup(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    if (success) Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? "Signup Successful"
                              : controller.error ?? "Failed",
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // go back to login
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
      TextEditingController controller,
      String hint,
      IconData icon, {
        bool obscure = false,
        Widget? suffix,
      }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.lightBlueAccent),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFF1A1D24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}
