import 'package:flutter/material.dart';

class MetricRow extends StatelessWidget {
  final IconData leftIcon;
  final String leftText;
  final IconData midIcon;
  final String midText;
  final IconData rightIcon;
  final String rightText;

  const MetricRow({
    super.key,
    required this.leftIcon,
    required this.leftText,
    required this.midIcon,
    required this.midText,
    required this.rightIcon,
    required this.rightText,
  });

  Widget _item(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white70),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _item(leftIcon, leftText),
          _item(midIcon, midText),
          _item(rightIcon, rightText),
        ],
      ),
    );
  }
}
