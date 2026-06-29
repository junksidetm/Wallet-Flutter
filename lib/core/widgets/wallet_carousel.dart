import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// WalletCarousel: An extremely expressive Material 3 CarouselView.
class WalletCarousel extends StatefulWidget {
  final List<Widget> cards;
  final double itemExtent;
  final ValueChanged<int>? onPageChanged;

  const WalletCarousel({
    super.key,
    required this.cards,
    this.itemExtent = 320.0,
    this.onPageChanged,
  });

  @override
  State<WalletCarousel> createState() => _WalletCarouselState();
}

class _WalletCarouselState extends State<WalletCarousel> {
  late CarouselController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
    _controller.addListener(() {
      final index = (_controller.offset / widget.itemExtent).round();
      if (index != _currentIndex && index >= 0 && index < widget.cards.length) {
        setState(() {
          _currentIndex = index;
        });
        widget.onPageChanged?.call(index);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) return const SizedBox();

    return SizedBox(
      height: 200,
      child: CarouselView(
        controller: _controller,
        itemExtent: widget.itemExtent,
        shrinkExtent: 200.0,
        onTap: (index) {
          HapticFeedback.lightImpact();
        },
        children: widget.cards,
      ),
    );
  }
}

/// WalletCardData is a helper widget to wrap inside the WalletCarousel.
class WalletCardTemplate extends StatelessWidget {
  final String accountName;
  final String balance;
  final String lastFourDigits;
  final Color cardColor;

  const WalletCardTemplate({
    super.key,
    required this.accountName,
    required this.balance,
    required this.lastFourDigits,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                accountName,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.contactless, color: Colors.white.withValues(alpha: 0.8)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                balance,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '•••• •••• •••• $lastFourDigits',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
