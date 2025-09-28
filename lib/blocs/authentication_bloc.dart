import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  late final StreamSubscription<MyUser?> _streamSubscription;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    // Đăng ký handler trước
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);

    // Lắng nghe user từ repo
    _streamSubscription = _userRepository.user().listen((myUser) {
      add(AuthenticationUserChanged(myUser));
    });
  }

  void _onAuthenticationUserChanged(
      AuthenticationUserChanged event,
      Emitter<AuthenticationState> emit,
      ) {
    if (event.user == null) {
      emit(const AuthenticationState.unauthenticated());
    }
    else if(event.user == MyUser.empty) {
      emit(const AuthenticationState.unknown());
    }
    else {
      emit(AuthenticationState.authenticated(event.user!));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
