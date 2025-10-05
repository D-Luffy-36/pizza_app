import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';
import 'blocs/authentication_bloc.dart';
import 'config/responsive_config.dart';
import 'package:provider/provider.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final config = ResponsiveConfig.of(constraints.maxWidth);

        return Provider<ResponsiveConfig>.value(
          value: config,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pizza App',
            theme: ThemeData(primarySwatch: Colors.red),
            home:  MyAppView(), // PizzaGrid có thể đọc ResponsiveConfig
          ),
        );
      },
    );
  }
}
