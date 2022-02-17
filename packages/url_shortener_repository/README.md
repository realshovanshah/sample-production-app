<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Url Shortener Repository

A repository for all functionality related to url shortening.

## Getting started

Add `url_shortener_repository` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

## Usage

Simply use the `UrlShortenerRepositoryImpl` class to create a instance with a default implementation.

```dart
final repo = UrlShortenerRepositoryImpl();
```

A fake implementation , `FakeUrlShortenerRepositoryImpl` can also be used for testing purposes.

```dart
final repo = FakeUrlShortenerRepositoryImpl();
```

## APIs

`getOriginalUrl()`

Retrieves the original url for the given **aliasId**.

Returns a result type of either a **UrlShortenerFailure** or a **OriginalUrl** data.

`shortenUrl()`

Shortens a given url of type **OriginalUrl**.

Returns a result of either a **UrlShortenerFailure or a **ShortenedUrl\*\* data.

## Failures

Maps all exception to strongly typed `UrlShortenerFailure`s.
