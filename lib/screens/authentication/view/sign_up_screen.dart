import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../widgets/my_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(userRepository: context.read<UserRepository>()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đăng ký thành công!")),
              );
            } else if (state is SignUpFailure) {
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        _buildNameField(),
                        const SizedBox(height: 16),
                        _buildEmailField(),
                        const SizedBox(height: 16),
                        _buildPasswordField(),
                        const SizedBox(height: 16),
                        _buildConfirmPasswordField(),
                        const SizedBox(height: 24),
                        _buildSignUpButton(context),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                // Overlay spinner khi loading
                if (state is SignUpLoading)
                  Container(
                    color: Colors.black45,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return MyTextField(
      labelText: "Username",
      controller: nameController,
      isPassword: false,
      validator: (v) => v == null || v.isEmpty ? "Nhập Username" : null,
      prefixIcon: Icons.person_outline,
    );
  }

  Widget _buildEmailField() {
    return MyTextField(
      labelText: "Email",
      controller: emailController,
      isPassword: false,
      validator: (v) {
        if (v == null || v.isEmpty) return "Nhập email";
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v))
          return "Email không hợp lệ";
        return null;
      },
      prefixIcon: Icons.email_outlined,
    );
  }

  Widget _buildPasswordField() {
    return MyTextField(
      labelText: "Mật khẩu",
      controller: passwordController,
      isPassword: true,
      validator: (v) => v == null || v.length < 6 ? "Mật khẩu >= 6 ký tự" : null,
      prefixIcon: Icons.lock_outline,
    );
  }

  Widget _buildConfirmPasswordField() {
    return MyTextField(
      labelText: "Xác nhận mật khẩu",
      controller: confirmController,
      isPassword: true,
      validator: (v) => v != passwordController.text ? "Mật khẩu không khớp" : null,
      prefixIcon: Icons.lock_outline,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<SignUpBloc>().add(
              SignUpRequired(
                user: MyUser(
                  userId: '',
                  email: emailController.text.trim(),
                  name: nameController.text.trim(),
                  hasActiveCart: false,
                ),
                password: passwordController.text.trim(),
              ),
            );
          }
        },
        child: const Text(
          "Đăng ký",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
