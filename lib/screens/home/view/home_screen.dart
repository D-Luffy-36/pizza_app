import 'package:flutter/material.dart';
import 'package:pizza_app/screens/authentication/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Class MyApp gốc của bạn
class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      theme: ThemeData(fontFamily: 'Inter'), // Tùy chỉnh font nếu có
      home: Scaffold(
        // Nền màu xám nhẹ cho body
        backgroundColor: const Color(0xFFF3F4F6), // gray-100

        // Sử dụng CustomAppBar đã thiết kế lại
        appBar:  CustomAppBar(
          title: "Home Screen",
          onLogout: () {
            context.read<SignInBloc>().add(SignOutRequired());
          },
        ),


        body: Center(
          // Sử dụng InfoCard thay vì Text("hello")
          child: InfoCard(
            title: "Chào mừng trở lại!",
            content: "Giao diện hiện đại này sử dụng header tối, bóng đổ mềm và màu sắc rực rỡ để cải thiện thẩm mỹ.",
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;

  const CustomAppBar({super.key, required this.title, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1F2937),
      elevation: 8,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.person_outline, color: Colors.white),
        onPressed: () {
          // TODO: Xử lý mở profile
          print("Mở profile");
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // Xử lý sự kiện thông báo
            print("Thông báo");
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {
            // Xử lý sự kiện cài đặt
            print("Cài đặt");
          },
        ),
        // Nút Logout trực tiếp
        TextButton.icon(
          onPressed: () {
            // TODO: Xử lý logout
            // Dispatch event logout
            onLogout!();
            print("Đăng xuất thành công");
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Thẻ thông tin nổi bật, tương đương với InfoCard trong React ví dụ
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16, // Bóng đổ mạnh hơn cho cảm giác nổi bật
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Bo góc lớn
      ),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100, // indigo-100
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.indigo.shade600, // indigo-600
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Xử lý sự kiện chi tiết
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                // indigo-600
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
                // Nút rộng tối đa
                elevation: 6,
              ),
              child: const Text(
                'View Details',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
