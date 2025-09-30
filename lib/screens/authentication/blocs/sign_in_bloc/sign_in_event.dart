part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}


final class SignInWithEmailAndPasswordRequested extends SignInEvent {
  final String email;
  final String password;

  const SignInWithEmailAndPasswordRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignOutRequired extends SignInEvent {}

