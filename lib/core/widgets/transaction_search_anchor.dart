import 'package:flutter/material.dart';

/// TransactionSearchAnchor: A pure Material 3 Expressive search component.
/// It uses [SearchAnchor] to create a floating search bar that smoothly 
/// morphs into a full-screen search experience when tapped.
class TransactionSearchAnchor extends StatefulWidget {
  final String hintText;
  
  const TransactionSearchAnchor({
    super.key,
    this.hintText = 'Search transactions...',
  });

  @override
  State<TransactionSearchAnchor> createState() => _TransactionSearchAnchorState();
}

class _TransactionSearchAnchorState extends State<TransactionSearchAnchor> {
  final SearchController _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SearchAnchor(
      searchController: _searchController,
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: Icon(Icons.search, color: theme.colorScheme.onSurfaceVariant),
          trailing: [
            Tooltip(
              message: 'Filter',
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.tune, color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          ],
          hintText: widget.hintText,
          hintStyle: WidgetStatePropertyAll(
            theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0), // Flat expressive M3 look
          backgroundColor: WidgetStatePropertyAll(theme.colorScheme.surfaceContainerHigh),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        // In a real implementation, this would filter real transactions.
        // For now, it returns expressive placeholder tiles.
        return List<ListTile>.generate(3, (int index) {
          final String item = 'Recent Transaction ${index + 1}';
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.secondaryContainer,
              child: Icon(Icons.receipt_long, color: theme.colorScheme.onSecondaryContainer, size: 20),
            ),
            title: Text(item, style: theme.textTheme.titleMedium),
            subtitle: Text('Tap to view details', style: theme.textTheme.bodySmall),
            onTap: () {
              controller.closeView(item);
            },
          );
        });
      },
    );
  }
}
