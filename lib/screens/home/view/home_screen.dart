import 'package:flutter/material.dart';
import 'package:pizza_app/blocs/authentication_bloc.dart';
import 'package:pizza_app/blocs/authentication_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/home/widgets/custom_app_bar.dart';
import 'package:pizza_app/screens/home/widgets/pizza_grid.dart';
import 'package:pizza_repository/pizza_repository.dart';
import '../../../config/responsive_config.dart';


// Class MyApp gốc của bạn
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // Sử dụng CustomAppBar đã thiết kế lại
      appBar: CustomAppBar(
        title: "Home Screen",
        onLogout: () {
          context.read<AuthenticationBloc>().add(LoggedOut());
        },
      ),
      body: PizzaGrid(pizzas: mockPizzas,), // Chỉ gọi widget con
    );
  }
}
