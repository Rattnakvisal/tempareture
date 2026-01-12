import 'package:flutter/material.dart';
import 'glass_card.dart';

class IconGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const IconGlassButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: GlassCard(
        radius: 14,
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: Colors.white70),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF5C8DFF), Color(0xFF7A5CFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5C8DFF).withOpacity(0.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SecondaryButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: GlassCard(
        radius: 16,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Icon(icon, color: Colors.white70),
      ),
    );
  }
}
