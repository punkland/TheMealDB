import 'package:flutter/material.dart';
import 'package:themealdb/core/theme/app_theme.dart';

class EmptyStateMessage extends StatelessWidget {
  final String message;

  const EmptyStateMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: AppTheme.text16Mon,
        textAlign: TextAlign.center,
      ),
    );
  }
}
