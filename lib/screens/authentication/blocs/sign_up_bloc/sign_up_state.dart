part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String errorMessage;
  SignUpFailure({required this.errorMessage});
}