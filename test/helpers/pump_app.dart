import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/features/url_shortener/state/url_shortener_cubit.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );
  }

  Future<void> pumpMaterialWidget(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Material(child: widget),
      ),
    );
  }

  Future<void> pumpAppWithDependencies(
    Widget widget, {
    UrlShortenerRepository? repository,
    UrlShortenerCubit? cubit,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: repository,
        child: MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: (cubit != null)
                ? BlocProvider.value(value: cubit, child: widget)
                : widget,
          ),
        ),
      ),
    );
  }

  Future<void> pumpWidgetWithDependencies(
    Widget widget, {
    UrlShortenerRepository? repository,
    UrlShortenerCubit? cubit,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: repository,
        child: (cubit != null)
            ? BlocProvider.value(value: cubit, child: widget)
            : widget,
      ),
    );
  }
}
