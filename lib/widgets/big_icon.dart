import 'package:flutter/material.dart';

class BigWeatherLikeIcon extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final bool drops;

  const BigWeatherLikeIcon({
    super.key,
    required this.icon,
    required this.accent,
    this.drops = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 8,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    accent.withOpacity(0.9),
                    accent.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Icon(icon, size: 96, color: Colors.white.withOpacity(0.92)),
          if (drops) ...[
            Positioned(bottom: 12, left: 56, child: _drop()),
            Positioned(bottom: 4, left: 78, child: _drop()),
            Positioned(bottom: 12, left: 94, child: _drop()),
          ],
        ],
      ),
    );
  }

  Widget _drop() {
    return Container(
      width: 10,
      height: 22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF59B7FF), Color(0xFF2B6BFF)],
        ),
      ),
    );
  }
}
