import 'package:pizza_repository/pizza_repository.dart';

import 'models.dart';

class Pizza {
  final String pizzaId;
  final String name;

  final String picture;
  final bool isVeg;
  final int spicy; // độ cay: 1,2,3
  final String description;
  final int price;
  final int discount;
  final Macros macros; // thông tin dinh dưỡng

  const Pizza({
    required this.pizzaId,
    required this.picture,
    required this.isVeg,
    required this.spicy,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.macros,
  });

  // copyWith để tạo Pizza mới dựa trên Pizza cũ
  Pizza copyWith({
    String? pizzaId,
    String? picture,
    bool? isVeg,
    int? spicy,
    String? name,
    String? description,
    int? price,
    int? discount,
    Macros? macros,
  }) {
    return Pizza(
      pizzaId: pizzaId ?? this.pizzaId,
      picture: picture ?? this.picture,
      isVeg: isVeg ?? this.isVeg,
      spicy: spicy ?? this.spicy,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      macros: macros ?? this.macros,
    );
  }


  PizzaEntity toEntity() {
    return PizzaEntity(
      pizzaId: pizzaId,
      picture: picture,
      isVeg: isVeg,
      spicy: spicy,
      name: name,
      description: description,
      price: price,
      discount: discount,
      macros: macros.toEntity(),
    );
  }

  static Pizza fromEntity(PizzaEntity entity) {
    return Pizza(
      pizzaId: entity.pizzaId,
      picture: entity.picture,
      isVeg: entity.isVeg,
      spicy: entity.spicy,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      discount: entity.discount,
      macros: Macros.fromEntity(entity.macros),
    );
  }

}
