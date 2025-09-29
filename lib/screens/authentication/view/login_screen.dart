import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../screen.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => SignInBloc(
        userRepository: context.read<UserRepository>(), // giờ lấy được
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6), // gray-100
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocListener<SignInBloc, SignInState>(
                listener: (context, state) {
                  if (state is SignInLoading) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (context) =>
                              const Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    // Đóng dialog nếu đang mở
                    Navigator.of(context, rootNavigator: true).pop();

                    if (state is SignInSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đăng nhập thành công!')),
                      );
                    } else if (state is SignInFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [_buildLoginForm(context)],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        _buildLogo(),
        const SizedBox(height: 16),
        _buildTitle(),
        const SizedBox(height: 24),
        _buildEmailField(emailController),
        const SizedBox(height: 16),
        _buildPasswordField(passwordController),
        const SizedBox(height: 24),
        _buildLoginButton(context),
        const SizedBox(height: 16),
        _buildRegisterLink(),
      ],
    );
  }

  // 🍕 Logo
  Widget _buildLogo() {
    return const Icon(
      Icons.local_pizza, // đổi thành pizza icon
      size: 80,
      color: Colors.deepOrange,
    );
  }

  // Title
  Widget _buildTitle() {
    return const Text(
      "Đăng nhập Pizza",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.deepOrange,
      ),
    );
  }

  // Email input
  Widget _buildEmailField(TextEditingController emailController) {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  // Password input
  Widget _buildPasswordField(TextEditingController passwordController) {
    return TextField(
      obscureText: true,
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: "Mật khẩu",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock_outline),
      ),
    );
  }

  // Login button
  Widget _buildLoginButton(BuildContext context) {

    return ElevatedButton(
      onPressed: () {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        // TODO: handle login
        context.read<SignInBloc>().add(
          SignInWithEmailAndPasswordRequested(email: email, password: password),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        "Đăng nhập",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Register link
  Widget _buildRegisterLink() {
    return TextButton(
      onPressed: () {
        // TODO: handle register navigation
      },
      child: const Text("Chưa có tài khoản? Đăng ký"),
    );
  }
}
