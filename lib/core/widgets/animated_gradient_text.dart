import 'package:flutter/material.dart';

/// AnimatedGradientText: A highly expressive text widget for main balances or headers.
/// It cycles a gradient across the text to draw attention and feel premium.
class AnimatedGradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final List<Color>? colors;

  const AnimatedGradientText({
    super.key,
    required this.text,
    this.style,
    this.colors,
  });

  @override
  State<AnimatedGradientText> createState() => _AnimatedGradientTextState();
}

class _AnimatedGradientTextState extends State<AnimatedGradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientColors = widget.colors ?? [
      theme.colorScheme.primary,
      theme.colorScheme.tertiary,
      theme.colorScheme.secondary,
      theme.colorScheme.primary,
    ];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: gradientColors,
              stops: const [0.0, 0.33, 0.66, 1.0],
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            widget.text,
            style: widget.style ?? theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w900),
          ),
        );
      },
    );
  }
}
