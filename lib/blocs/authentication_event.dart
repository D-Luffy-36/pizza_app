import 'package:flutter/foundation.dart';
import 'package:user_repository/user_repository.dart';
import 'package:equatable/equatable.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final MyUser? user;

  const AuthenticationUserChanged(this.user);

}