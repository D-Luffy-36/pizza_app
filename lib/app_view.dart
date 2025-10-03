import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_state.dart';
import 'screens/authentication/view/welcom_screen.dart';
import 'screens/screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.light(background: Colors.grey.shade200, onBackground: Colors.black, primary: Colors.blue, onPrimary: Colors.white)),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthenticationStatus.authenticated:
              return const HomeScreen();
            case AuthenticationStatus.unauthenticated:
              return const WelcomeScreen();
            default:
              return const SplashScreen(); // chỉ khi app mới load
          }
        },
      )
      ,
    );
  }
}
