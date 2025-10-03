import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'password_vadilation_state.dart';

class PasswordVadilationCubit extends Cubit<PasswordValidationState> {
  PasswordVadilationCubit() : super(PasswordValidationState());

  void validate(String password) {
    emit(
      PasswordValidationState(
        upper: password.contains(RegExp(r'[A-Z]')),
        lower: password.contains(RegExp(r'[a-z]')),
        number: password.contains(RegExp(r'[0-9]')),
        special: password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')),
        min8: password.length >= 8,
      ),
    );
  }
}
