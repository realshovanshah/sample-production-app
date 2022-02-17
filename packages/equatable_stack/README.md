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

# Equatable Stack

An implementation of the [Stack] data structure, which also supports value equality.

## Features

- Value equality
- A copyWith Method

## Getting started

Add `equatable_stack` as a [dependency in your pubspec.yaml file](https://flutter.io/using-packages/).

## Usage

Simply use the `Stack` class to create a instance.

```dart
final foo = Stack<int>(); // a empty stack
final bar = Stack.of(const [1, 2, 3]); // stack from a iterable
```

## Additional information

<!-- todo: add link to the repo -->

Feel free to [create an issue.]() here. Contributing guide will be added soon.
PRs and new feature requests are always welcome.
