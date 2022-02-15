import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/app/components/components.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:link_shortener/l10n/l10n.dart';

/// {@template shorten_url_bottom_sheet}
/// A [BottomSheet] with a [TextField] and an [ActionButton],
/// that takes in a URL and displays the shortened URL.
/// {@endtemplate}
@visibleForTesting
class ShortenUrlFooter extends StatefulWidget {
  /// {@macro shorten_url_bottom_sheet}
  const ShortenUrlFooter({Key? key}) : super(key: key);

  @override
  State<ShortenUrlFooter> createState() => _ShortenUrlFooterState();
}

class _ShortenUrlFooterState extends State<ShortenUrlFooter> {
  late final TextEditingController _urlController;
  late final GlobalKey<FormState> _formKey;
  late final UrlShortenerCubit _shortenerCubit;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _shortenerCubit = context.read<UrlShortenerCubit>();
  }

  String get _textValue => _urlController.text.trim();

  void _onFormSubmit() {
    log('_onFormSubmit: Form value: $_textValue', name: 'UrlShortenerPage');
    final _formState = _formKey.currentState;
    if (mounted && _formState!.validate()) {
      _shortenerCubit.shortenUrl(_textValue);
    }
  }

  String _onCopy() {
    log('_onCopy: Copied to clipboard, $_textValue', name: 'UrlShortenerPage');
    _urlController.clear();
    _shortenerCubit.resetStatus();
    return _textValue;
  }

  void _handleFailure(String msg) {
    log('_handleFailure: displaying message, $msg', name: 'UrlShortenerPage');
    showAppSnackbar(context, status: SnackbarStatus.error, message: msg);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<UrlShortenerCubit, UrlShortenerState>(
      listener: (context, state) {
        if (state.status == UrlShortenerStatus.failure) {
          _handleFailure(state.errorMessage ?? l10n.unexpectedErrorText);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  hintText: l10n.urlPrompt,
                  border: const OutlineInputBorder(),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ShortenUrlAction(
                      onSend: _onFormSubmit,
                      onCopy: _onCopy,
                    ),
                  ),
                ),
                validator: requiredValidator(l10n.urlRequired),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
}

class _ShortenUrlAction extends StatelessWidget {
  const _ShortenUrlAction({
    Key? key,
    required this.onSend,
    required this.onCopy,
  }) : super(key: key);

  final VoidCallback onSend;
  final ValueGetter<String> onCopy;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<UrlShortenerCubit, UrlShortenerState,
        UrlShortenerStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return status == UrlShortenerStatus.success
            ? CopyActionButton(onTap: onCopy)
            : ActionButton(
                onTap: onSend,
                loading: status == UrlShortenerStatus.loading,
              );
      },
    );
  }
}

// class _ErrorMessage extends StatelessWidget {
//   const _ErrorMessage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     return BlocSelector<UrlShortenerCubit, UrlShortenerState, String?>(
//       selector: (state) => state.errorMessage,
//       builder: (context, msg) {
//         if (msg == null) return const SizedBox.shrink();
//         return Text(
//           msg.isEmpty ? l10n.unexpectedErrorText : msg,
//           style: Theme.of(context).inputDecorationTheme.errorStyle,
//         );
//       },
//     );
//   }
// }
