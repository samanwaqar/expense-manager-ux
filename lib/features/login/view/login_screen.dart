import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/app_routes.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<LoginController>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1115), // deep dark
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to continue managing your expenses",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                _field(
                  controller: emailController,
                  hint: "Email",
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 15),

                _field(
                  controller: passwordController,
                  hint: "Password",
                  icon: Icons.lock_outline,
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
                      final success = await controller.login(
                        emailController.text,
                        passwordController.text,
                      );

                      if (success) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.main,
                              (route) => false,
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(controller.error ?? "Login Failed"),
                          ),
                        );
                      }
                    },

                    child: const Text(
                      "LOGIN",
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
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup'); // go to signup
                        },
                        child: const Text(
                          "Sign up",
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
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
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
