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


final mockPizzas = [
  Pizza(
    pizzaId: "p1",
    name: "Margherita",
    picture: "https://cdn.pixabay.com/photo/2014/04/22/02/56/pizza-329523_1280.jpg",
    isVeg: true,
    spicy: 1,
    description: "Classic Margherita with mozzarella, tomatoes and basil.",
    price: 120,
    discount: 15,
    macros:  Macros(
      calories: 250,
      proteins: 12,
      fat: 8,
      carbs: 30,
    ),
  ),
  Pizza(
    pizzaId: "p2",
    name: "Pepperoni Feast",
    picture: "https://cdn.pixabay.com/photo/2014/04/22/02/55/pasta-329522_1280.jpg",
    isVeg: false,
    spicy: 2,
    description: "Loaded with spicy pepperoni and cheese.",
    price: 150,
    discount: 20,
    macros:  Macros(
      calories: 320,
      proteins: 18,
      fat: 15,
      carbs: 35,
    ),
  ),
  Pizza(
    pizzaId: "p3",
    name: "Veggie Supreme",
    picture: "https://cdn.pixabay.com/photo/2022/03/19/09/40/pizza-7078188_1280.jpg",
    isVeg: true,
    spicy: 0,
    description: "Topped with mushrooms, capsicum, onion and olives.",
    price: 135,
    discount: 10,
    macros:  Macros(
      calories: 280,
      proteins: 10,
      fat: 9,
      carbs: 32,
    ),
  ),
  Pizza(
    pizzaId: "p4",
    name: "BBQ Chicken",
    picture: "https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_1280.jpg",
    isVeg: false,
    spicy: 3,
    description: "Grilled chicken with smoky BBQ sauce and cheese.",
    price: 170,
    discount: 25,
    macros:  Macros(
      calories: 340,
      proteins: 22,
      fat: 14,
      carbs: 36,
    ),
  ),
];
