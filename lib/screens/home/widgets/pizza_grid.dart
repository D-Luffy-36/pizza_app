import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/home/bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/view/pizza_detail_screen.dart';
import 'package:pizza_app/screens/home/widgets/pizza_card.dart';
import 'package:pizza_repository/pizza_repository.dart';
import '../../../config/responsive_config.dart';
import '../../../contants/pizza_assets.dart';


class PizzaGrid extends StatelessWidget {

  final List<Pizza> pizzas;
  const PizzaGrid({super.key, required this.pizzas});

  @override
  Widget build(BuildContext context) {
    final config = context.read<ResponsiveConfig>();
    return BlocBuilder<GetPizzaBloc, GetPizzaState>(
      builder: (context, state) {
        if (state is GetPizzaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPizzaFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is GetPizzaSuccess) {
          return _buildPizzaGrid(context, state.pizzas, config);
        } else {
          return _buildPizzaGrid(context, pizzas, config);
        }
      },
    );
  }

  /// Grid khi có dữ liệu thật
  Widget _buildPizzaGrid(
    BuildContext context,
    List pizzas,
    ResponsiveConfig config,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: config.crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: config.aspectRatio,
        ),
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          return PizzaCard(pizza: pizzas[index]);
        },
      ),
    );
  }

  /// Grid placeholder (mock UI)
  Widget _buildPlaceholderGrid(ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: config.crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: config.aspectRatio,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildPizzaPlaceholder(context, config);
        },
      ),
    );
  }

  /// UI cho một item placeholder pizza
  Widget _buildPizzaPlaceholder(BuildContext context,ResponsiveConfig config) {
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
          highlightColor: Colors.deepOrange.withOpacity(0.2), // 🔥 khi hold toàn card đổi màu
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>  PizzaDetailScreen(pizza: ,),
            //   ),
            // );
          },
          child: Column(
            children: [
              const SizedBox(height: 12),
              _buildPizzaAvatar(config),
              const SizedBox(height: 12),
              _buildTags(config),
              Flexible(child: _buildPizzaDescription(config)),
              _buildPriceAndAddButton(config),
            ],
          ),
        ),
      ),
    );
  }

  /// Avatar pizza
  Widget _buildPizzaAvatar(ResponsiveConfig config) {
    return CircleAvatar(
      radius: config.avatarRadius,
      backgroundImage: AssetImage(PizzaAssets.pizza4),
    );
  }

  /// Tag row (Non-Veg, Balanced)
  Widget _buildTags(ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: _buildTag(
              Icons.no_food,
              'Non-Veg',
              Colors.red,
              fontSize: config.fontSmall,
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: _buildTag(
              Icons.eco,
              'Balanced',
              Colors.green,
              fontSize: config.fontSmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Nội dung mô tả pizza
  Widget _buildPizzaDescription(ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cheesy Marvel",
            style: TextStyle(
              fontSize: config.fontTitle,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            "A cheesy delight with a perfect balance of flavors.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: config.fontSmall,
              color: Colors.black54,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Giá và nút Add
  Widget _buildPriceAndAddButton(ResponsiveConfig config) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$15.99',
                style: TextStyle(
                  fontSize: config.fontBody,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                  decorationThickness: 2,
                ),
              ),
              Text(
                '\$12.99',
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
