import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:link_shortener/features/url_shortener/view/url_shortener_page.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// {@template app}
/// The root widget of our application.
/// {@endtemplate}
class App extends StatelessWidget {
  /// {@macro app}
  const App({
    Key? key,
    required UrlShortenerRepository urlShortenerRepository,
  })  : _urlShortenerRepository = urlShortenerRepository,
        super(key: key);

  final UrlShortenerRepository _urlShortenerRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => _urlShortenerRepository,
      child: const AppView(),
    );
  }
}

/// {@template app_view}
/// [MaterialApp] which sets the [UrlShortenerPage] as the `home`.
/// {@endtemplate}
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const UrlShortenerPage(),
    );
  }
}
