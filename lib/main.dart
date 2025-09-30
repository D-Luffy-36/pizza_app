import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/app.dart';
import 'package:pizza_app/screens/authentication/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/authentication/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:pizza_app/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';
import 'blocs/authentication_bloc.dart';
import 'blocs/authentication_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Bloc.observer = SimpleBlocObserver();

  final userRepository = FirebaseUserRepository();

  runApp(
    RepositoryProvider<UserRepository>.value(
      value: userRepository, // tạo 1 lần, dùng chung
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AuthenticationBloc(
                  userRepository: context.read<UserRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => SignInBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   final userRepository = FirebaseUserRepository(); // repo bạn viết dùng FirebaseAuth
//
//   final authBloc = AuthenticationBloc(userRepository: userRepository);
//
//   // Lắng nghe state thay đổi
//   final subscription = authBloc.stream.listen((state) {
//     print('Bloc state thay đổi: $state');
//   });
//
//   // Ở đây không cần add event thủ công,
//   // vì bloc đã lắng nghe stream từ repo.user().
//   // Khi bạn login/logout bằng FirebaseAuth thì state sẽ tự update.
//
//   // Đợi 10s rồi đóng bloc
//   Future.delayed(const Duration(seconds: 10), () async {
//     await subscription.cancel();
//     await authBloc.close();
//   });
// }

Future<void> testSignUpBloc(UserRepository userRepository) async {
  final signUpBloc = SignUpBloc(userRepository: userRepository);

  final subscription = signUpBloc.stream.listen((state) {
    if (state is SignUpInitial) {
      print("SignUp State: Initial");
    } else if (state is SignUpLoading) {
      print("SignUp State: Loading...");
    } else if (state is SignUpSuccess) {
      print("SignUp State: Success!");
    } else if (state is SignUpFailure) {
      print("SignUp State: Failure, error: ${state.errorMessage}");
    }
  });

  final testUser = MyUser(
    userId: '',
    email: 'test@example.com',
    name: 'Test User',
    hasActiveCart: false,
  );
  signUpBloc.add(SignUpRequired(user: testUser, password: '123456'));

  // Đợi bloc chạy xong (async)
  await Future.delayed(Duration(seconds: 2));

  // Hủy subscription và đóng bloc
  await subscription.cancel();
  await signUpBloc.close();
}

Future<void> testSignBloc() async {
  try {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: "admin@gmail.com",
          password: "admin@gmail.com",
        );
    print("Login success: ${user.user?.email}");
  } on FirebaseAuthException catch (e) {
    print("Firebase Auth Error: ${e.code} - ${e.message}");
  } catch (e) {
    print("Other Error: $e");
  }
}
