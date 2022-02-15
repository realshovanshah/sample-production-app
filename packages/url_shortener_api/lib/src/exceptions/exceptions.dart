/// {@template network_exception}
/// Thrown if a network exception occurs while making a api request.
/// {@endtemplate}
class NetworkException implements Exception {
  /// {@macro network_exception}
  const NetworkException([this.message]);

  /// {@template exception_message}
  /// The message of the exception thrown.
  /// Only used for debugging purposes.
  /// {@endtemplate}
  final String? message;
}

/// {@template invalid_request_exception}
/// Thrown if the api request returns a non-200 status code.
/// {@endtemplate}
class InvalidRequestException implements Exception {
  /// {@macro invalid_request_exception}
  const InvalidRequestException([this.statusCode, this.message]);

  /// The status code of the response.
  final int? statusCode;

  /// {@macro exception_message}
  final String? message;
}

/// {@template bad_response_exception}
/// Thrown if the api request returns a unexpected response.
/// {@endtemplate}
class BadResponseException implements Exception {
  /// {@macro bad_response_exception}
  const BadResponseException({this.message});

  /// {@macro exception_message}
  final String? message;
}
