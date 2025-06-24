import 'package:flutter/material.dart';

class SocialLoginPlaceholderBtn extends StatelessWidget {
  final IconData icon;
  final int? iconSize;
  final String label;
  final Color iconColor;
  final VoidCallback? onPressed;

  const SocialLoginPlaceholderBtn({
    super.key,
    this.iconSize = 15,
    required this.icon,
    required this.label,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor, size: iconSize?.toDouble() ?? 15.0),
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        side: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }
}
