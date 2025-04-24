import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/utils/app_localizations.dart';

class ErrorStateMessage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorStateMessage({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400, size: 40.sp),
            SizedBox(height: 5.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTheme.text16Mon,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(AppLocalizations.of(context).translate('retry')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
