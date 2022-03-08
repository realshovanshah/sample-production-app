import 'package:flutter/material.dart';

/// {@template action_button}
/// Action button of the UrlShortener Design System.
/// Shows a [CircularProgressIndicator] when [loading] is set to true.
/// {@endtemplate}
class ActionButton extends StatelessWidget {
  /// {@macro action_button}
  const ActionButton({
    Key? key,
    required this.onTap,
    this.loading = false,
  }) : super(key: key);

  /// The callback that is called when the [IconButton] is tapped.
  final VoidCallback onTap;

  /// Indicates whether the button is in a loading state.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
      ),
      child: IconButton(
        icon: loading
            ? const Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Icon(Icons.send, color: Colors.white),
        onPressed: loading ? null : onTap,
      ),
    );
  }
}

/// {@template copy_action_button}
/// A button that copies the text to the clipboard when tapped.
/// {@endtemplate}
class CopyActionButton extends StatelessWidget {
  /// {@macro copy_action_button}
  const CopyActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  /// Callback that returns the text to be copied.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Icon(Icons.copy, color: Colors.black),
    );
  }
}

/// {@template sort_action_button}
/// A button with sort icons, that changes when tapped.
/// {@endtemplate}
class SortActionButton extends StatelessWidget {
  /// {@macro sort_action_button}
  SortActionButton({Key? key, required this.onSort}) : super(key: key);

  /// Callback for when the sort button is tapped.
  final VoidCallback onSort;
  final ValueNotifier<_SortDirection> _sortDirectionNotifier =
      ValueNotifier(_SortDirection.down);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<_SortDirection>(
      valueListenable: _sortDirectionNotifier,
      builder: (context, state, _) {
        return InkWell(
          onTap: () {
            _sortDirectionNotifier.value = state == _SortDirection.down
                ? _SortDirection.up
                : _SortDirection.down;
            onSort();
          },
          child: state == _SortDirection.down
              ? const Icon(Icons.arrow_downward)
              : const Icon(Icons.arrow_upward),
        );
      },
    );
  }
}

enum _SortDirection { up, down }
