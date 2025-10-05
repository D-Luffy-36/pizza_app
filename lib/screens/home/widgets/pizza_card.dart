import 'package:flutter/material.dart';
import 'package:pizza_app/screens/home/view/pizza_detail_screen.dart';
import 'package:pizza_repository/pizza_repository.dart';
import '../../../config/responsive_config.dart';
import 'package:provider/provider.dart';

class PizzaCard extends StatelessWidget {
  final Pizza pizza;
  const PizzaCard({super.key, required this.pizza});

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ResponsiveConfig>(context, listen: false);

    return Material(
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.grey.withOpacity(0.4),
          highlightColor: Colors.deepOrange.withOpacity(0.2),
          onTap: () {
            print("Tapped on ${pizza.name}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PizzaDetailScreen(pizza: pizza)),
            );

          },
          child: Column(
            children: [
              const SizedBox(height: 12),
              _buildPizzaAvatar(pizza, config),
              const SizedBox(height: 12),
              _buildTags(pizza, config),
              Flexible(child: _buildPizzaDescription(pizza, config)),
              _buildPriceAndAddButton(pizza, config),
            ],
          ),
        ),
      ),
    );
  }

  /// Avatar pizza
  Widget _buildPizzaAvatar(Pizza pizza, ResponsiveConfig config) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12), // 👈 bo góc nhẹ, có thể bỏ nếu muốn vuông
      child: Image.network(
        pizza.picture,
        width: config.avatarRadius * 3, // giữ tỉ lệ tương đương avatar cũ
        height: config.avatarRadius * 2,
        fit: BoxFit.cover,
      ),
    );
  }

  /// Tag row (Veg/Non-Veg)
  Widget _buildTags(Pizza pizza, ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: _buildTag(
              pizza.isVeg ? Icons.eco : Icons.no_food,
              pizza.isVeg ? "Veg" : "Non-Veg",
              pizza.isVeg ? Colors.green : Colors.red,
              fontSize: config.fontSmall,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: _buildTag(
              Icons.auto_awesome, // hoặc Icons.scale, Icons.eco
              "Balanced",
              Colors.teal, // xanh ngọc dịu, chữ trắng nổi bật
              fontSize: config.fontSmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Mô tả pizza
  Widget _buildPizzaDescription(Pizza pizza, ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 👈 thay vì center theo trục dọc
        children: [
          // Tên pizza
          Text(
            pizza.name,
            style: TextStyle(
              fontSize: config.fontTitle,   // 👈 font lớn hơn
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Mô tả
          Text(
            pizza.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: config.fontSmall,
              color: Colors.black54,
              height: 1.3,
            ),
            maxLines: 2, // 👈 cắt bớt để không "vỡ"
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Giá + nút Add
  Widget _buildPriceAndAddButton(Pizza pizza, ResponsiveConfig config) {
    final hasDiscount = pizza.discount > 0;
    final priceAfterDiscount = (pizza.price - pizza.discount);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasDiscount)
                Text(
                  '\$${pizza.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: config.fontBody,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 2,
                  ),
                ),
              Text(
                '\$${priceAfterDiscount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: config.fontPrice,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildAddButton(config),
        ],
      ),
    );
  }

  /// Nút Add tròn
  Widget _buildAddButton(ResponsiveConfig config) {
    return Material(
      color: Colors.black,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: Colors.white24,
        onTap: () {
          print("Add button clicked!");
          // TODO: xử lý thêm vào giỏ hàng
        },
        child: SizedBox(
          width: config.iconRadius * 2,
          height: config.iconRadius * 2,
          child: Icon(Icons.add, color: Colors.white, size: config.iconSize),
        ),
      ),
    );
  }
}

/// Widget tag nhỏ (icon + text)
Widget _buildTag(
    IconData icon,
    String text,
    Color color, {
      double fontSize = 12,
    }) {
  return Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: fontSize),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ],
    ),
  );
}
