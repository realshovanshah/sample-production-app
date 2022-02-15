import 'package:bloc/bloc.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:link_shortener/features/url_shortener/models/models.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

part 'url_shortener_state.dart';
part 'url_shortener_cubit.freezed.dart';

/// {@template url_shortener_cubit}
/// Bloc which manages the current [UrlShortenerState]. Externally, should only
/// depend on a [UrlShortenerRepository] and nothing else.
/// {@endtemplate}
class UrlShortenerCubit extends Cubit<UrlShortenerState> {
  /// {@macro url_shortener_cubit}
  UrlShortenerCubit({
    required UrlShortenerRepository urlShortenerRepository,
  })  : _urlShortenerRepository = urlShortenerRepository,
        super(UrlShortenerState.idle());

  final UrlShortenerRepository _urlShortenerRepository;

  /// Interacts with the [UrlShortenerCubit] and updates
  /// the state with the result of the shortened url.
  Future<void> shortenUrl(String url) async {
    emit(state.copyWith(status: UrlShortenerStatus.loading));

    final _urlResult = await _urlShortenerRepository.shortenUrl(
      originalUrl: OriginalUrl(url: url),
    );
    _urlResult.when(
      failure: _handleFailureResult,
      success: _handleSuccessResult,
    );
  }

  void _handleSuccessResult(ShortenedUrl shortenedUrl) {
    final _urlModel = UrlModel.fromEntity(shortenedUrl);
    final _recents = state.recents.copyWith(_urlModel);
    emit(state.copyWith(status: UrlShortenerStatus.success, recents: _recents));
  }

  void _handleFailureResult(UrlShortenerFailure failure) {
    emit(
      state.copyWith(
        status: UrlShortenerStatus.failure,
        errorMessage: failure.message,
      ),
    );
  }

  /// Changes the state to [UrlShortenerState.idle]
  /// while retaining data.
  void resetStatus() => emit(state.copyWith(status: UrlShortenerStatus.idle));
}
