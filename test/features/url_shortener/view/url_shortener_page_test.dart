import 'package:bloc_test/bloc_test.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/features/url_shortener/state/url_shortener_cubit.dart';
import 'package:link_shortener/features/url_shortener/view/view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

import '../../../helpers/helpers.dart';

class MockUrlShortenerCubit extends MockCubit<UrlShortenerState>
    implements UrlShortenerCubit {}

class MockUrlShortenerRepository extends Mock
    implements UrlShortenerRepository {}

void main() {
  group('UrlShortenerPage', () {
    late UrlShortenerCubit _cubit;
    late MockUrlShortenerRepository _repository;

    setUp(() {
      _cubit = MockUrlShortenerCubit();
      _repository = MockUrlShortenerRepository();
      when(() => _cubit.state).thenReturn(
        UrlShortenerState.idle(recents: Stack()),
      );
    });

    test('instantiates', () {
      expect(const UrlShortenerPage(), isA<UrlShortenerPage>());
    });

    testWidgets('renders correctly with UrlShortenerView', (tester) async {
      await tester.pumpAppWithDependencies(
        const UrlShortenerPage(),
        cubit: _cubit,
        repository: _repository,
      );
      expect(find.byType(UrlShortenerView), findsOneWidget);
    });

    group('UrlShortenerView', () {
      testWidgets(
        'renders correctly with a ShortenedUrlFooter and a RecentUrlList',
        (tester) async {
          await tester.pumpAppWithDependencies(
            const UrlShortenerView(),
            cubit: _cubit,
          );
          expect(find.byType(ShortenUrlFooter), findsOneWidget);
          expect(find.byType(RecentUrlList), findsOneWidget);
        },
      );
    });
  });
}
