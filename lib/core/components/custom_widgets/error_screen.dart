import 'package:flutter/material.dart';
// import '../../utils/text_styels.dart'; // Uncomment when available

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final IconData? icon;
  final String? retryButtonText;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.onRetry,
    this.icon,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Error Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade400,
                  ),
                ),

                const SizedBox(height: 24),

                // Error Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xffc2c2c2),
                    fontWeight: FontWeight.bold,
                  ) ?? const TextStyle(
                    fontSize: 18,
                    color: Color(0xffc2c2c2),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                // Retry Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(retryButtonText ?? "إعادة المحاولة"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}