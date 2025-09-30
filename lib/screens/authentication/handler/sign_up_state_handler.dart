import 'package:flutter/material.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpStateHandler {
  bool _isDialogVisible = false;

  void handle(BuildContext context, SignUpState state) {
    if (state is SignUpLoading) {
      // Hiển thị loading nếu chưa có dialog
      if (!_isDialogVisible) {
        _isDialogVisible = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ).then((_) {
          // Reset flag khi dialog bị đóng
          _isDialogVisible = false;
        });
      }
    } else {
      // Đóng dialog nếu đang mở và context còn hợp lệ
      if (_isDialogVisible) {
        try {
          if (Navigator.canPop(context)) Navigator.pop(context);
        } catch (_) {
          // Nếu pop lỗi do context bị dispose, reset flag
          _isDialogVisible = false;
        }
      }

      // Hiển thị thông báo
      if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đăng ký thành công!")),
        );
      } else if (state is SignUpFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }
    }
  }
}
