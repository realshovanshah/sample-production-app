import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Stack', () {
    group('supports value comparison', () {
      test('when elements are same, is equal', () {
        final stackA = Stack.of(const [1, 2, 3]);
        final stackB = Stack.of(const [1, 2, 3]);
        expect(stackA, equals(stackB));
      });

      test('when elements are different, is not equal', () {
        final stackA = Stack.of(const [1, 2, 4]);
        final stackB = Stack.of(const [1, 2, 3]);
        expect(stackA, isNot(equals(stackB)));
      });

      test('elements in different order, not equal', () {
        final stackA = Stack.of(const [1, 2, 3]);
        final stackB = Stack.of(const [2, 1, 3]);
        expect(stackA, isNot(equals(stackB)));
      });
    });

    group('instantiation', () {
      group('() default constructor', () {
        test('instantiates, correct', () {
          expect(Stack<int>(), isA<Stack<int>>());
        });

        test('instantiates, incorrect', () {
          expect(Stack<int>(), isNot(isA<Stack<double>>()));
        });
      });

      group('.of factory', () {
        test('instantiates with elements, correct', () {
          expect(
            Stack.of(const ['any', 'elem']),
            equals(Stack.of(const ['any', 'elem'])),
          );
        });

        test('instantiates with elements, incorrect ', () {
          expect(
            Stack.of(const ['any', 'elem']),
            isNot(equals(Stack.of(const ['unexpected', 'elem']))),
          );
        });
      });
    });

    group('.peek', () {
      test('returns last element, correct', () {
        final stack = Stack.of(const [1, 2, 3]);
        expect(stack.peek, equals(3));
      });

      test('returns last element, incorrect', () {
        final stack = Stack.of(const [4, 5, 6]);
        expect(stack.peek, isNot(equals(5)));
      });

      test('does not return the 1st element', () {
        final stack = Stack.of(const [4, 5, 6]);
        expect(stack.peek, isNot(equals(1)));
      });
    });

    group('.reversed', () {
      test('returns reversed stack, correct', () {
        final stack = Stack.of(const [1, 2, 3]);
        expect(stack.reversed(), equals(Stack.of(const [3, 2, 1])));
      });

      test('returns reversed stack, incorrect', () {
        final stack = Stack.of(const [4, 5, 6]);
        expect(stack.reversed(), isNot(equals(Stack.of(const [6, 4, 5]))));
      });

      test('empty stack', () {
        final stack = Stack<int>.of(const []);
        expect(stack.reversed(), equals(Stack<int>.of(const [])));
      });

      test('only 1 element in the stack', () {
        final stack = Stack.of(const [1]);
        expect(stack.reversed(), equals(Stack.of(const [1])));
      });
    });

    group('.copyWith', () {
      test('returns a copy, correct', () {
        final stack = Stack.of(const [1, 2, 3]);
        expect(
          stack.copyWith(4),
          equals(Stack.of(const [1, 2, 3, 4])),
        );
      });

      test('returns a copy, incorrect', () {
        final stack = Stack.of(const [1, 2, 3]);
        expect(
          stack.copyWith(2),
          isNot(equals(Stack.of(const [2, 1, 2, 3]))),
        );
      });
    });
  });
}
