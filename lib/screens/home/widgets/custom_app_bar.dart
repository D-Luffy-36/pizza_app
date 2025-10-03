import 'package:flutter/material.dart';
import '../../../contants/pizza_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;

  const CustomAppBar({super.key, required this.title, this.onLogout});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 8,
      centerTitle: false,
      title: Row(
        mainAxisSize: MainAxisSize.min, // ⬅️ Chỉ chiếm chỗ vừa đủ
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              PizzaAssets.pizza8,
              height:
                  MediaQuery.of(context).size.height *
                  0.06, // 6% chiều cao màn hình
              width:
                  MediaQuery.of(context).size.width *
                  0.16, // 12% chiều rộng màn hình
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'PIZZA',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            print("Giỏ hàng được nhấn!");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => CartPage()),
            // );
          },
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          tooltip: "Xem giỏ hàng",
        ),
        // Nút Logout trực tiếp
        IconButton(
          onPressed: () {
            if (onLogout != null) {
              onLogout!();
            }
            print("Đăng xuất thành công");
          },
          icon: const Icon(Icons.logout, color: Colors.black),
          tooltip: "Logout", // Hover sẽ hiển thị chữ
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
