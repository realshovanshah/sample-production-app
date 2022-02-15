import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:url_shortener_api/src/exceptions/exceptions.dart';
import 'package:url_shortener_api/src/models/models.dart';
import 'package:url_shortener_api/src/types/types.dart';

/// {@template url_shortener_api}
/// A dart api client for the NU Link Shortener API.
/// Throws one of [NetworkException], [InvalidRequestException] or
/// [BadResponseException] if the response is not successful.
/// {@endtemplate}
class UrlShortenerApi {
  /// {@macro url_shortener_api}
  UrlShortenerApi({
    Dio? dio,
  }) : _dio = dio ?? Dio()
          ..options = BaseOptions(
            baseUrl: _kUrlBase,
            contentType: Headers.jsonContentType,
          );

  /// The endpoint used for requests related to Url Shortening.
  @visibleForTesting
  static const aliasUrl = '/api/alias';

  static const _kUrlBase = 'https://url-shortener-nu.herokuapp.com';

  final Dio _dio;

  /// Shorten a given URL.
  ///
  /// Endpoint: `POST /api/alias`
  Future<ShortenedUrl> shortenUrl({required OriginalUrl originalUrl}) async {
    final responseBody = await _request<JsonMap>(
      httpMethod: _HttpMethod.post,
      endpoint: aliasUrl,
      data: originalUrl.toJson(),
    );
    try {
      return ShortenedUrl.fromJson(responseBody);
    } catch (_) {
      throw const BadResponseException();
    }
  }

  /// Get the original URL for a given alias.
  ///
  /// Endpoint: `GET /api/alias/:id`
  Future<OriginalUrl> getOriginalUrl({required String aliasId}) async {
    final responseBody = await _request<JsonMap>(
      httpMethod: _HttpMethod.get,
      endpoint: '$aliasUrl/$aliasId',
    );
    try {
      return OriginalUrl.fromJson(responseBody);
    } catch (e) {
      throw BadResponseException(message: '$e');
    }
  }

  /// make a get or post request to the given endpoint.
  Future<T> _request<T>({
    required _HttpMethod httpMethod,
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    Response<dynamic> response;
    const validStatusCode = 200;

    try {
      switch (httpMethod) {
        case _HttpMethod.get:
          response = await _dio.get<dynamic>(endpoint);
          break;
        case _HttpMethod.post:
          response = await _dio.post<dynamic>(endpoint, data: data);
          break;
      }
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode;
      final msg = e.message;
      if (statusCode == 404) throw InvalidRequestException(statusCode, msg);
      throw const NetworkException();
    }

    if (response.statusCode != validStatusCode) {
      throw InvalidRequestException(response.statusCode);
    }

    try {
      return response.data as T;
    } catch (_) {
      throw const BadResponseException();
    }
  }
}

// A Http method representation.
enum _HttpMethod {
  get,
  post,
}
