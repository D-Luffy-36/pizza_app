part of 'get_pizza_bloc.dart';

@immutable
sealed class GetPizzaState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetPizzaInitial extends GetPizzaState {}

final class GetPizzaLoading extends GetPizzaState {}

final class GetPizzaSuccess extends GetPizzaState {
  final List<Pizza> pizzas;

  GetPizzaSuccess({required this.pizzas});
  List<Object?> get props => [pizzas];
}

final class GetPizzaFailure extends GetPizzaState {
  final String errorMessage;

  GetPizzaFailure({required this.errorMessage});
  List<Object?> get props => [errorMessage];
}