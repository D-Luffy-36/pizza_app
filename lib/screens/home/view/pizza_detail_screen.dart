import 'package:flutter/material.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:provider/provider.dart';
import '../../../config/responsive_config.dart';
import 'package:intl/intl.dart';

class PizzaDetailScreen extends StatefulWidget {
  final Pizza pizza;

  const PizzaDetailScreen({Key? key, required this.pizza}) : super(key: key);

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  int _quantity = 1;

  final _currencyFormat = NumberFormat.currency(locale: "en_US", symbol: "\$");

  String _formatPrice(num price) {
    return _currencyFormat.format(price);
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ResponsiveConfig>(context, listen: false);
    final padding = config.padding;
    final titleFont = config.fontTitle;
    final bodyFont = config.fontBody;
    final pizza = widget.pizza;
    final media = MediaQuery.of(context);
    final width = media.size.width;
    final imageHeight = width * 0.6;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, padding),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImage(pizza, imageHeight),
                    const SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleAndMeta(pizza, titleFont),
                          const SizedBox(height: 12),
                          _buildPriceRow(pizza, bodyFont),
                          const SizedBox(height: 12),
                          _buildDescription(pizza, bodyFont),
                          const SizedBox(height: 16),
                          _buildMacros(pizza, bodyFont),
                          SizedBox(height: padding + 70), // leave space for action bar
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: _buildActionBar(context, pizza, padding, bodyFont),
    );
  }

  Widget _buildTopBar(BuildContext context, double padding) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding / 2, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrange, Colors.orangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          Material(
            color: Colors.white,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () => Navigator.of(context).pop(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back, size: 24, color: Colors.deepOrange),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Pizza Details",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildImage(Pizza pizza, double height) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: Hero(
            tag: 'pizza-image-${pizza.pizzaId}',
            child: Image.network(
              pizza.picture,
              height: height,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: height,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(pizza.isVeg ? Icons.spa : Icons.restaurant_menu, color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  pizza.isVeg ? "Vegetarian" : "Non-Vegetarian",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndMeta(Pizza pizza, double titleFont) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            pizza.name,
            style: TextStyle(fontSize: titleFont, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildSpicyIcons(pizza.spicy),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("ID: ${pizza.pizzaId}", style: const TextStyle(fontSize: 12)),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSpicyIcons(int spicy) {
    const max = 5;
    return Row(
      children: List.generate(
        max,
            (i) => Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(
            Icons.local_fire_department,
            size: 16,
            color: i < spicy ? Colors.redAccent : Colors.grey.withOpacity(0.3),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(Pizza pizza, double bodyFont) {
    final price = pizza.price;
    final discount = pizza.discount ?? 0;
    final effective = price * (1 - discount / 100);

    return Row(
      children: [
        Text(_formatPrice(effective), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        const SizedBox(width: 10),
        if (discount > 0)
          Row(
            children: [
              Text(
                _formatPrice(price),
                style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough, color: Colors.grey[600]),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                child: Text("-${discount.toStringAsFixed(0)}%", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
              )
            ],
          )
      ],
    );
  }

  Widget _buildDescription(Pizza pizza, double bodyFont) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Text(pizza.description ?? "", style: TextStyle(fontSize: bodyFont, height: 1.4)),
      ],
    );
  }

  Widget _buildMacros(Pizza pizza, double bodyFont) {
    final macros = pizza.macros;
    if (macros == null) return const SizedBox.shrink();

    Widget chip(String label, String value, IconData icon, Color color) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 3))],
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nutrition Facts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: [
            chip("Calories", "${macros.calories} kcal", Icons.local_fire_department, Colors.redAccent),
            chip("Protein", "${macros.proteins} g", Icons.fitness_center, Colors.green),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            chip("Fat", "${macros.fat} g", Icons.opacity, Colors.orange),
            chip("Carbs", "${macros.carbs} g", Icons.grid_on, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context, Pizza pizza, double padding, double bodyFont) {
    final price = pizza.price;
    final discount = pizza.discount ?? 0;
    final effective = price * (1 - discount / 100);
    final total = effective * _quantity;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.deepOrange],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(padding, 12, padding, MediaQuery.of(context).padding.bottom + 12),
      child: Row(
        children: [
          // quantity selector
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                IconButton(
                  onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                  icon: const Icon(Icons.remove, color: Colors.redAccent),
                  splashRadius: 20,
                ),
                Text('$_quantity', style: TextStyle(fontSize: bodyFont, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add, color: Colors.green),
                  splashRadius: 20,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added $_quantity x ${pizza.name} — Total ${_formatPrice(total)}")),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepOrange,
                elevation: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  const SizedBox(width: 10),
                  Text("Add ${_formatPrice(total)}", style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
