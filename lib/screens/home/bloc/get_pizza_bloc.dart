import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';


part 'get_pizza_event.dart';
part 'get_pizza_state.dart';

class GetPizzaBloc extends Bloc<GetPizzaEvent, GetPizzaState> {

  final PizzaRepository _pizzaRepository;

  GetPizzaBloc({required PizzaRepository pizzaRepository})
      : _pizzaRepository = pizzaRepository,
        super(GetPizzaInitial()) {
    on<GetPizzaRequired>(_onGetPizzaRequired);
  }

  Future<void> _onGetPizzaRequired(
      GetPizzaRequired event, Emitter<GetPizzaState> emit) async {
    emit(GetPizzaLoading());
    try {
      final pizzas = await _pizzaRepository.fetchPizzas();
      emit(GetPizzaSuccess(pizzas: pizzas));
    } catch (e) {
      emit(GetPizzaFailure(errorMessage: e.toString()) );
    }
  }


}
