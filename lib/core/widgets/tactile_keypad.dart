import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TactileKeypad: An expressive, haptic-enabled numeric keypad.
/// Uses Material 3 rounded shapes and surface containers for a premium feel
/// when users are entering transaction amounts.
class TactileKeypad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final VoidCallback onBackspace;
  final VoidCallback onSubmit;

  const TactileKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onBackspace,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate button size based on available width
        final double spacing = 12.0;
        final double btnWidth = (constraints.maxWidth - (spacing * 2)) / 3;
        final double btnHeight = 64.0;

        Widget buildKey(String value, {Widget? icon, Color? color, Color? iconColor}) {
          final theme = Theme.of(context);
          return SizedBox(
            width: btnWidth,
            height: btnHeight,
            child: Material(
              color: color ?? Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (value == '<') {
                    onBackspace();
                  } else if (value == '>') {
                    onSubmit();
                  } else {
                    onKeyPressed(value);
                  }
                },
                child: Center(
                  child: icon ?? Text(
                    value,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        final theme = Theme.of(context);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [buildKey('1'), buildKey('2'), buildKey('3')],
            ),
            SizedBox(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [buildKey('4'), buildKey('5'), buildKey('6')],
            ),
            SizedBox(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [buildKey('7'), buildKey('8'), buildKey('9')],
            ),
            SizedBox(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildKey('.', 
                  icon: Text('.', style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurfaceVariant,
                  )),
                ),
                buildKey('0'),
                buildKey('<', 
                  icon: Icon(Icons.backspace_rounded, color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
