import 'dart:ui';
import 'package:flutter/material.dart';

/// ExpressiveMorphingFab: A floating action button that morphs into a frosted glass menu.
/// Pure native fluid animation for a highly premium interaction.
class ExpressiveMorphingFab extends StatefulWidget {
  final Widget openIcon;
  final Widget closeIcon;
  final List<Widget> menuItems;

  const ExpressiveMorphingFab({
    super.key,
    required this.openIcon,
    required this.closeIcon,
    required this.menuItems,
  });

  @override
  State<ExpressiveMorphingFab> createState() => _ExpressiveMorphingFabState();
}

class _ExpressiveMorphingFabState extends State<ExpressiveMorphingFab> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Frosted Glass Overlay & Menu Items
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleMenu,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  color: theme.colorScheme.surface.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          
        // Menu Items appearing
        Positioned(
          bottom: 80,
          right: 0,
          child: SizeTransition(
            sizeFactor: _scaleAnimation,
            axisAlignment: -1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widget.menuItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: item,
              )).toList(),
            ),
          ),
        ),

        // Morphing FAB
        FloatingActionButton(
          onPressed: _toggleMenu,
          elevation: _isOpen ? 0 : 4,
          backgroundColor: _isOpen ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.primary,
          foregroundColor: _isOpen ? theme.colorScheme.onSurface : theme.colorScheme.onPrimary,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
              child: _isOpen ? widget.closeIcon : widget.openIcon,
            ),
          ),
        ),
      ],
    );
  }
}
