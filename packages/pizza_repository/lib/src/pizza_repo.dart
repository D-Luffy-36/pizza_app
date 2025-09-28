import 'models/models.dart';

abstract class PizzaRepository {
  /// Lấy danh sách pizza
  Future<List<Pizza>> fetchPizzas();
}