import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.imageUrl,
    required this.action,
  });

  final String imageUrl;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: action,
      icon: Image.asset(
        imageUrl,
        height: 24,
        width: 24,
      ),
    );
  }
}
