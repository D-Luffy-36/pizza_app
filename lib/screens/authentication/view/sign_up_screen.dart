import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
import '../cubits/password_vadilation/password_vadilation_cubit.dart';
import '../../../components/my_text_field.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(
          create:
              (context) =>
                  SignUpBloc(userRepository: context.read<UserRepository>()),
        ),
        BlocProvider(create: (_) => PasswordVadilationCubit()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đăng ký thành công!")),
              );
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
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
                        _buildPasswordField(context),
                        const SizedBox(height: 16),
                        SizedBox(height: 16),
                        _buildPasswordRequirements(context),// 👈 thêm Row ở đây
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
                    child: const Center(child: CircularProgressIndicator()),
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

  Widget _buildPasswordField(BuildContext context) {
    return MyTextField(
      labelText: "Mật khẩu",
      controller: passwordController,
      isPassword: true,
      prefixIcon: Icons.lock_outline,
      onChanged: (value) {
        context.read<PasswordVadilationCubit>().validate(
          value,
        ); // ✅ trigger cubit
      },
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
      onChanged: (value) {},
    );
  }

  Widget _buildConfirmPasswordField() {
    return MyTextField(
      labelText: "Xác nhận mật khẩu",
      controller: confirmController,
      isPassword: true,
      validator:
          (v) => v != passwordController.text ? "Mật khẩu không khớp" : null,
      prefixIcon: Icons.lock_outline,
      onChanged: (value) {},
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

Widget _buildRequirement(String text, bool satisfied) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0), // thêm khoảng cách dọc
    child: Row(
      children: [
        Icon(
          satisfied ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 18,
          color: satisfied ? Colors.green : Colors.grey, // xanh nếu đạt, xám nếu chưa
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: satisfied ? Colors.green : Colors.grey,
            fontWeight: satisfied ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPasswordRequirements(BuildContext context) {
  return BlocBuilder<PasswordVadilationCubit, PasswordValidationState>(
    builder: (context, state) {
      return Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Yêu cầu mật khẩu:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              _buildRequirement("Ít nhất 1 chữ hoa (A-Z)", state.upper),
              _buildRequirement("Ít nhất 1 chữ thường (a-z)", state.lower),
              _buildRequirement("Ít nhất 1 số (0-9)", state.number),
              _buildRequirement("Ít nhất 1 ký tự đặc biệt", state.special),
              _buildRequirement("Độ dài ≥ 8 ký tự", state.min8),
            ],
          ),
        ),
      );
    },
  );
}
