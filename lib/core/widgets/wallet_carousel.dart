import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// WalletCarousel: An extremely expressive Material 3 CarouselView.
/// Uses Flutter's native CarouselView to create a horizontal scrolling
/// list of bank cards/accounts that dynamically scale and squish at the edges.
class WalletCarousel extends StatelessWidget {
  final List<Widget> cards;
  final double itemExtent;

  const WalletCarousel({
    super.key,
    required this.cards,
    this.itemExtent = 320.0, // Default width for a bank card
  });

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) return const SizedBox();

    return SizedBox(
      height: 200, // Fixed height for standard bank cards
      child: CarouselView(
        itemExtent: itemExtent,
        shrinkExtent: 200.0, // The size it shrinks to at the edges
        onTap: (index) {
          HapticFeedback.lightImpact();
          // Further tap handling could be passed via callbacks
        },
        children: cards,
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
