import '../config/responsive_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveProvider extends StatelessWidget {
  final Widget child;
  const ResponsiveProvider({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final config = ResponsiveConfig.of(screenWidth);

    return Provider<ResponsiveConfig>.value(
      value: config,
      child: child,
    );
  }
}
