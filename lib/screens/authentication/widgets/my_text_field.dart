import 'package:flutter/material.dart';

typedef Validator = String? Function(String?);

class MyTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Validator? validator;
  final bool isPassword; // thêm flag xác định đây có phải password hay không
  final IconData? prefixIcon;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.isPassword = false, // default false
    this.prefixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // chỉ ẩn text nếu là password
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(widget.prefixIcon ?? (widget.isPassword ? Icons.lock_outline : Icons.text_fields)),
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: _toggleVisibility,
        )
            : null,
      ),
      validator: widget.validator,
    );
  }
}
