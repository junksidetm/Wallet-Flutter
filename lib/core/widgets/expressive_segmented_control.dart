import 'package:flutter/material.dart';

enum TransactionFilter { income, expense, transfer }

/// ExpressiveSegmentedControl: A Material 3 SegmentedButton wrapper.
/// Allows for rapid, premium filtering of data (like transaction types)
/// while fully embracing the dynamic M3 ColorScheme.
class ExpressiveSegmentedControl extends StatefulWidget {
  final TransactionFilter initialSelection;
  final ValueChanged<TransactionFilter> onSelectionChanged;

  const ExpressiveSegmentedControl({
    super.key,
    this.initialSelection = TransactionFilter.expense,
    required this.onSelectionChanged,
  });

  @override
  State<ExpressiveSegmentedControl> createState() => _ExpressiveSegmentedControlState();
}

class _ExpressiveSegmentedControlState extends State<ExpressiveSegmentedControl> {
  late TransactionFilter _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSelection;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SegmentedButton<TransactionFilter>(
      segments: const <ButtonSegment<TransactionFilter>>[
        ButtonSegment<TransactionFilter>(
          value: TransactionFilter.income,
          label: Text('Income'),
          icon: Icon(Icons.arrow_downward_rounded),
        ),
        ButtonSegment<TransactionFilter>(
          value: TransactionFilter.expense,
          label: Text('Expense'),
          icon: Icon(Icons.arrow_upward_rounded),
        ),
        ButtonSegment<TransactionFilter>(
          value: TransactionFilter.transfer,
          label: Text('Transfer'),
          icon: Icon(Icons.swap_horiz_rounded),
        ),
      ],
      selected: <TransactionFilter>{_selected},
      onSelectionChanged: (Set<TransactionFilter> newSelection) {
        setState(() {
          _selected = newSelection.first;
        });
        widget.onSelectionChanged(_selected);
      },
      showSelectedIcon: true,
      style: ButtonStyle(
        // Enhance the selected state color to use secondary container for a premium feel
        backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return theme.colorScheme.secondaryContainer;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return theme.colorScheme.onSecondaryContainer;
          }
          return theme.colorScheme.onSurfaceVariant;
        }),
      ),
    );
  }
}
