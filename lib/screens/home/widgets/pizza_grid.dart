import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/home/bloc/get_pizza_bloc.dart';
import 'package:pizza_app/screens/home/widgets/pizza_card.dart';

class PizzaGrid extends StatelessWidget {
  const PizzaGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPizzaBloc, GetPizzaState>(
      builder: (context, state) {
        if (state is GetPizzaLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPizzaFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is GetPizzaSuccess) {
          final pizzas = state.pizzas;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 4,
            ),
            itemCount: pizzas.length,
            itemBuilder: (context, index) {
              return PizzaCard(pizza: pizzas[index]);
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 3 / 4,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          );
        }
      },
    );
  }
}
