import '../pizza_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// Implementation for Firebase pizza repository
class FirebasePizzaRepository implements PizzaRepository {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

/*
  Firestore → QuerySnapshot → docs (List<DocumentSnapshot>)
  → data() (Map<String, dynamic>)
  → Pizza.fromJson(Map)
  → List<Pizza>
*/

  @override
  Future<List<Pizza>> fetchPizzas() async {
    try {

      // Lấy dữ liệu từ Firestore
      final pizzaSnapshot = await pizzaCollection.get();
      final snapShotDocs = pizzaSnapshot.docs;

      // bước 1: Firestore document -> Map<String, dynamic>
      final pizzasDocs = snapShotDocs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      // bước 2: Map -> Entity
      final pizzasEntities = pizzasDocs
          .map((item) => PizzaEntity.fromDocument(item))
          .toList();

      // bước 3: Entity -> Model (domain model)
      final pizzasModels = pizzasEntities
          .map((entityObject) => Pizza.fromEntity(entityObject))
          .toList();

      return pizzasModels;
    } catch (e) {
      throw Exception('Error fetching pizzas: $e');
    }
  }

}

