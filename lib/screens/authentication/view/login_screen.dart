import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../../../components/my_text_field.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Đăng nhập thành công!")),
            );
            // Nếu dùng AuthWrapper, app sẽ tự điều hướng
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.5,
                  child: _buildLoginForm(context),
                ),
              ),
              if (state is SignInLoading)
                Container(
                  color: Colors.black45,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          _buildEmailField(emailController),
          const SizedBox(height: 16),
          _buildPasswordField(passwordController),
          const SizedBox(height: 24),
          _buildLoginButton(context),
        ],
      ),
    );
  }

  Widget _buildEmailField(TextEditingController emailController) {
    return MyTextField(
      labelText: "Email",
      controller: emailController,
      isPassword: false,
      validator: (v) {
        if (v == null || v.isEmpty) return "Email không được để trống";
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v))
          return "Email không hợp lệ";
        return null;
      },
      prefixIcon: Icons.email_outlined,
    );
  }

  Widget _buildPasswordField(TextEditingController passwordController) {
    return MyTextField(
      labelText: "Mật khẩu",
      controller: passwordController,
      isPassword: true,
      validator: (v) => v == null || v.length < 6 ? "Mật khẩu >= 6 ký tự" : null,
      prefixIcon: Icons.lock_outline,
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<SignInBloc>().add(
              SignInWithEmailAndPasswordRequested(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
