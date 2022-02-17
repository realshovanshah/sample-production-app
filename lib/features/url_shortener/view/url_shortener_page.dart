import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:link_shortener/features/url_shortener/view/sections/recent_url_list.dart';
import 'package:link_shortener/features/url_shortener/view/sections/shornen_url_footer.dart';
import 'package:link_shortener/l10n/l10n.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// {@template link_shortener_page}
/// The root page of the Link Shortener App. Depends on an instance of
/// [UrlShortenerCubit] for interacting with the external layers.
/// {@endtemplate}
class UrlShortenerPage extends StatelessWidget {
  /// {@macro link_shortener_page}
  const UrlShortenerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UrlShortenerCubit(
        urlShortenerRepository: context.read<UrlShortenerRepository>(),
      ),
      child: const UrlShortenerView(),
    );
  }
}

/// {@template url_shortener_view}
/// Responds to [UrlShortenerState] changes and notifies
/// user actions to the [UrlShortenerCubit].
/// {@endtemplate}
class UrlShortenerView extends StatelessWidget {
  /// {@macro url_shortener_view}
  const UrlShortenerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        persistentFooterButtons: [
          AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: const ShortenUrlFooter(),
          ),
        ],
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.recentUrlTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            const Expanded(
              child: RecentUrlList(),
            ),
          ],
        ),
      ),
    );
  }
}
