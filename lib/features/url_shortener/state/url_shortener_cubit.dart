import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:link_shortener/features/url_shortener/models/models.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

part 'url_shortener_state.dart';

/// {@template url_shortener_cubit}
/// Bloc which manages the current [UrlShortenerState]. Externally, should only
/// depend on a [UrlShortenerRepository] and nothing else.
/// {@endtemplate}
class UrlShortenerCubit extends Cubit<UrlShortenerState> {
  /// {@macro url_shortener_cubit}
  UrlShortenerCubit({
    required UrlShortenerRepository urlShortenerRepository,
  })  : _urlShortenerRepository = urlShortenerRepository,
        super(UrlShortenerState.idle(recents: Stack()));

  final UrlShortenerRepository _urlShortenerRepository;

  /// Interacts with the [UrlShortenerCubit] and updates
  /// the state with the result of the shortened url.
  Future<void> urlShortened(String url) async {
    log('urlShortened: url, $url', name: 'UrlShortenerPage');
    emit(UrlShortenerState.loading(recents: state.recents));

    final _urlResult = await _urlShortenerRepository.shortenUrl(
      originalUrl: OriginalUrl(url: url),
    );
    _urlResult.when(
      failure: _handleFailureResult,
      success: _handleSuccessResult,
    );
  }

  /// Reverses the list of recently shortened urls
  /// while preserving the current state.
  void recentUrlsSorted() {
    final _reversedRecents = state.recents.reversed();
    emit(state.copyWith(recents: _reversedRecents));
  }

  /// Changes the state to [UrlShortenerState.idle]
  /// while retaining data if the url is cleared.
  void urlCleared(String url) {
    final _shortUrl = state.recentUrl;
    log('urlCleared: shortUrl, $_shortUrl', name: 'UrlShortenerPage');
    if (url != _shortUrl) emit(UrlShortenerState.idle(recents: state.recents));
  }

  /// Resets the cubit state to [UrlShortenerState.idle],
  /// and copies the recently shortened url to the clipboard (mock).
  void textCopied() {
    final _shortUrl = state.recentUrl;
    log('_onCopy: Copied to clipboard, $_shortUrl', name: 'UrlShortenerPage');
    _mockCopyToClipboard(_shortUrl);
    emit(UrlShortenerState.idle(recents: state.recents));
  }

  void _handleSuccessResult(ShortenedUrl shortenedUrl) {
    final _urlModel = UrlModel.fromEntity(shortenedUrl);
    final _recents = state.recents.copyWith(_urlModel);
    emit(UrlShortenerState.success(recents: _recents));
  }

  void _handleFailureResult(UrlShortenerFailure failure) {
    final recents = state.recents;
    emit(UrlShortenerState.failure(message: failure.message, recents: recents));
  }

  void _mockCopyToClipboard(String? url) {}
}
