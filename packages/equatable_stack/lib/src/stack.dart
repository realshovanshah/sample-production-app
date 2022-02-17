import 'package:flutter/foundation.dart';

/// {@template stack}
/// An implementation of the [Stack] data structure,
/// which also supports value equality.
/// {@endtemplate}
@immutable
class Stack<E> {
  /// {@macro stack}
  Stack();

  /// Returns a new stack with all objects of [iterable].
  factory Stack.of(Iterable<E> iterable) {
    return Stack<E>()..pushAll(iterable);
  }

  final _list = <E>[];

  /// Pushes an element to the top of the stack.
  void push(E val) => _list.add(val);

  /// Returns the top element of the stack.
  E pop() => _list.removeLast();

  /// Returns the top element of the stack without removing it.
  E get peek => _list.last;

  /// Checks if the stack has no elements.
  bool get isEmpty => _list.isEmpty;

  /// Checks if the stack has at least one element.
  bool get isNotEmpty => _list.isNotEmpty;

  /// Returns the number of elements in the stack.
  int get length => _list.length;

  /// Removes all objects from the stack.
  void clear() => _list.clear();

  /// Returns the current elements of this iterable modified by [toElement].
  Iterable<T> map<T>(T Function(E) toElement) => _list.map(toElement);

  /// Appends all objects of [iterable] on the top of the stack.
  void pushAll(Iterable<E> iterable) => _list.addAll(iterable);

  /// Copies the stack with [val] and returns a new stack.
  Stack<E> copyWith(E val) {
    return Stack<E>()
      ..pushAll(_list)
      ..push(val);
  }

  /// Override the equality operator.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Stack<E> &&
          runtimeType == other.runtimeType &&
          listEquals(_list, other._list);

  // Override the hashcode operator.
  @override
  int get hashCode => _list.hashCode;
  @override
  String toString() => _list.toString();
}
