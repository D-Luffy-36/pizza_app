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
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.deepOrange,
          secondary: Colors.deepOrangeAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white, // màu chữ/icon trong AppBar
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
          ),
        ),
      ),
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
