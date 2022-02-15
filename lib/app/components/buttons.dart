import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final ValueGetter<String> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(Icons.copy, color: Colors.black),
      onTap: () => Clipboard.setData(ClipboardData(text: onTap())),
    );
  }
}
