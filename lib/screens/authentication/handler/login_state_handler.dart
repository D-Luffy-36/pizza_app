import 'package:flutter/material.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';

void handleLoginState(BuildContext context, SignInState state) {
  if (state is SignInLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  } else {
    // Đóng dialog nếu đang mở
    Navigator.of(context, rootNavigator: true).pop();

    if (state is SignInSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công!')),
      );
    } else if (state is SignInFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage)),
      );
    }
  }
}
