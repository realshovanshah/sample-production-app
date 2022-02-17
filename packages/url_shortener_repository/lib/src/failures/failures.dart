import 'package:flutter/material.dart';

/// Represents a failure in the repository layer.
abstract class Failure implements Exception {}

/// {@template url_shortener_failure}
/// Returned when an exception is caught in the UrlShortenerRepository.
/// {@endtemplate}
@immutable
class UrlShortenerFailure extends Failure {
  /// {@macro url_shortener_failure}
  UrlShortenerFailure([this.message]);

  /// The message associated with the failure.
  final String? message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UrlShortenerFailure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'UrlShortenerFailure(message: $message)';
}
