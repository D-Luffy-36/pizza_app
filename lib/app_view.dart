import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_state.dart';
import 'screens/screen.dart';


class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Inter'),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.unknown:
              return const SplashScreen();
            case AuthenticationStatus.authenticated:
              return HomeScreen();
            case AuthenticationStatus.unauthenticated:
              return const LoginScreen();
          }
        },
      ),
    );
  }
}

