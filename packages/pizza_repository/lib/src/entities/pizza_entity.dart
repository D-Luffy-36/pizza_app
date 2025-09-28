import './entities.dart';

class PizzaEntity {
  final String pizzaId;
  final String name;
  final String picture;
  final bool isVeg;
  final int spicy; // độ cay: 1,2,3
  final String description;
  final int price;
  final int discount;
  final MacrosEntity macros; // thông tin dinh dưỡng

  const PizzaEntity({
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

  /// Convert object -> Firestore document
  Map<String, dynamic> toDocument() {
    return {
      'pizzaId': pizzaId,
      'picture': picture,
      'isVeg': isVeg,
      'spicy': spicy,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'macros': macros.toDocument(),
    };
  }

  /// Convert Firestore document -> object
  factory PizzaEntity.fromDocument(Map<String, dynamic> doc) {
    return PizzaEntity(
      pizzaId: doc['pizzaId'] as String? ?? '',
      picture: doc['picture'] as String? ?? '',
      isVeg: doc['isVeg'] as bool? ?? false,
      spicy: (doc['spicy'] as num?)?.toInt() ?? 1,
      name: doc['name'] as String? ?? '',
      description: doc['description'] as String? ?? '',
      price: (doc['price'] as num?)?.toInt() ?? 0,
      discount: (doc['discount'] as num?)?.toInt() ?? 0,
      macros: doc['macros'] != null
          ? MacrosEntity.fromDocument(doc['macros'] as Map<String, dynamic>)
          : MacrosEntity.empty, // fallback nếu macros null
    );
  }
}
