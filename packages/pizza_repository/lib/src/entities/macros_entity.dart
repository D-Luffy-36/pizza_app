class MacrosEntity{
  final int calories;
  final int proteins;
  final int fat;
  final int carbs;

  MacrosEntity({
    required this.calories,
    required this.proteins,
    required this.fat,
    required this.carbs,
  });

  static final empty = MacrosEntity(
    calories: 0,
    proteins: 0,
    fat: 0,
    carbs: 0,
  );

  Map<String, dynamic> toDocument(){
    return {
      'calories': calories,
      'proteins': proteins,
      'fat': fat,
      'carbs': carbs,
    };
  }

  static MacrosEntity fromDocument(Map<String, dynamic> doc){
    return MacrosEntity(
      calories: doc['calories'] ?? 0,
      proteins: doc['proteins'] ?? 0,
      fat: doc['fat'] ?? 0,
      carbs: doc['carbs'] ?? 0,
    );
  }

}