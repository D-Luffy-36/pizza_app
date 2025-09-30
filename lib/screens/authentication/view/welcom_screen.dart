import 'package:flutter/material.dart';
import './login_screen.dart';
import './sign_up_screen.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
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
              children: const [
                LoginScreen(),
                SignUpScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
