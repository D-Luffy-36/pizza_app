part of 'password_vadilation_cubit.dart';

class PasswordValidationState extends Equatable {
  final bool upper;
  final bool lower;
  final bool number;
  final bool special;
  final bool min8;

  const PasswordValidationState({
    this.upper = false,
    this.lower = false,
    this.number = false,
    this.special = false,
    this.min8 = false,
  });

  bool get allValid => upper && lower && number && special && min8;

  @override
  List<Object?> get props => [upper, lower, number, special, min8];
}

