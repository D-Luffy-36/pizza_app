import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import './login_screen.dart';
import './sign_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          TabBar(
            controller: tabController,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepOrange,
            tabs: const [
              Tab(text: 'Đăng nhập'),
              Tab(text: 'Đăng ký'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BlocProvider(
                  create: (context) => SignInBloc(
                    userRepository: context.read<UserRepository>(),
                  ),
                  child: LoginScreen(),
                ),
                SignUpScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
