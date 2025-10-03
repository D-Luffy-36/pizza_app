part of 'get_pizza_bloc.dart';

@immutable
sealed class GetPizzaEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class GetPizzaRequired extends GetPizzaEvent {}

