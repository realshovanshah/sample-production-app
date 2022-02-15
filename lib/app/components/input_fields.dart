import 'package:flutter/material.dart';

// Input fields of our design system.

/// Validator that validates the value is not null or empty.
FormFieldValidator<String> requiredValidator(String error) => (value) {
      if (value?.isEmpty ?? true) return error;
      return null;
    };

/// Validator that validates the value is not, null or empty.
@visibleForTesting
bool isEmptyOrNull(String? value) => value?.trim().isEmpty ?? true;
