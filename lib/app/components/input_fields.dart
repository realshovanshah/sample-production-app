import 'package:flutter/material.dart';

// Input fields of our design system.

/// Validates the given value is a URL.
/// Also validates that it is not null or empty.
FormFieldValidator<String> urlValidator() => (val) {
      if (isEmptyOrNull(val)) return 'URL cannot be empty.';
      if (isUrl(val!)) return null;
      return 'Please enter a valid url.';
    };

/// Validates the value is not, null or empty.
@visibleForTesting
bool isEmptyOrNull(String? value) => value?.trim().isEmpty ?? true;

/// Validates the value is a url.
@visibleForTesting
bool isUrl(String value) => value.contains(_urlRegex);

RegExp _urlRegex = RegExp(
  r'(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
);
