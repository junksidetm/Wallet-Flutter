import 'dart:math' as math;
import 'package:flutter/material.dart';

/// FluidMeshBackground: A highly expressive, premium animated background.
/// Uses a highly blurred CustomPainter to render slowly moving colorful blobs
/// based on the Material 3 ColorScheme (Primary, Secondary, Tertiary).
class FluidMeshBackground extends StatefulWidget {
  final Widget child;
  
  const FluidMeshBackground({super.key, required this.child});

  @override
  State<FluidMeshBackground> createState() => _FluidMeshBackgroundState();
}

class _FluidMeshBackgroundState extends State<FluidMeshBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Slow, perpetual animation
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: _MeshPainter(
                  progress: _controller.value,
                  colorScheme: Theme.of(context).colorScheme,
                ),
              );
            },
          ),
        ),
        // A subtle noise overlay could go here, but keeping it clean for performance.
        Positioned.fill(child: widget.child),
      ],
    );
  }
}

class _MeshPainter extends CustomPainter {
  final double progress;
  final ColorScheme colorScheme;

  _MeshPainter({required this.progress, required this.colorScheme});

  @override
  void paint(Canvas canvas, Size size) {
    // We use a high blur sigma for the frosted, blended mesh effect
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80)
      ..style = PaintingStyle.fill;

    // Center coordinates
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Time-based oscillation
    final t = progress * 2 * math.pi;

    // Blob 1: Primary Color (Moves in a large circle)
    paint.color = colorScheme.primary.withValues(alpha: 0.15);
    final dx1 = cx + math.cos(t) * 100;
    final dy1 = cy + math.sin(t) * 150;
    canvas.drawCircle(Offset(dx1, dy1), 180, paint);

    // Blob 2: Tertiary Color (Moves in an opposite figure-8)
    paint.color = colorScheme.tertiary.withValues(alpha: 0.15);
    final dx2 = cx + math.sin(t * 2) * 120;
    final dy2 = cy + math.cos(t) * 180;
    canvas.drawCircle(Offset(dx2, dy2), 150, paint);

    // Blob 3: Secondary Color (Pulses and shifts slightly)
    paint.color = colorScheme.secondary.withValues(alpha: 0.12);
    final dx3 = cx + math.cos(t + math.pi) * 80;
    final dy3 = cy + math.sin(t * 1.5) * 100;
    final radius3 = 160 + math.sin(t * 3) * 20;
    canvas.drawCircle(Offset(dx3, dy3), radius3, paint);
  }

  @override
  bool shouldRepaint(covariant _MeshPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.colorScheme != colorScheme;
  }
}
