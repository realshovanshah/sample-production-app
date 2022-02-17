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

# Url Shortener API

A dart implementation of the Nu Link Shortener API.

## Getting started

Add `url_shortener_api` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

## Usage

Base URL - https://url-shortener-nu.herokuapp.com

#### getOriginalUrl()

    Get the original URL for a given alias.

    Endpoint: `GET /api/alias/:id`

#### shortenUrl()

    Shorten a given URL.

    Endpoint: `POST /api/alias`

## Exceptions

#### 1. NetworkException

    Thrown if a network exception occurs while making a api request.

#### 2. InvalidRequestException

    Thrown if the api request returns a non-200 status code.

#### 3. BadResponseException

    Thrown if the api request returns a unexpected response.
