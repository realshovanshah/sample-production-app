import 'package:flutter/material.dart';

/// {@template app_snackbar}
/// Shows the Snackbar component of the design system.
/// {@endtemplate}
void showAppSnackbar(
  BuildContext context, {

  /// The widget's key.
  final Key? key,

  /// The snackbar's status.
  required final SnackbarStatus status,

  /// The snackbar's text message.
  required final String message,

  /// The snackbar's trailing action.
  final SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      buildCustomSnackbar(status: status, message: message, action: action),
    );
}

/// The status of the app [SnackBar].
enum SnackbarStatus {
  /// The success state of the snackbar.
  success,

  /// The error state of the snackbar.
  error,
}

/// Builds a custom Snackbar. Do not use directly.
/// Use [showAppSnackbar] instead.
@visibleForTesting
SnackBar buildCustomSnackbar({
  final Key? key,
  required final SnackbarStatus status,
  required final String message,
  final SnackBarAction? action,
}) =>
    SnackBar(
      key: key,
      action: action,
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      duration: _kSnackbarDuration,
      content: Row(
        children: [
          if (status == SnackbarStatus.success)
            const Icon(Icons.check_circle_outline, color: Colors.green)
          else
            const Icon(Icons.error, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );

const _kSnackbarDuration = Duration(seconds: 6);
