import 'package:bloc_test/bloc_test.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/components/buttons.dart';
import 'package:link_shortener/features/url_shortener/state/url_shortener_cubit.dart';
import 'package:link_shortener/features/url_shortener/view/sections/recent_url_list.dart';
import 'package:link_shortener/features/url_shortener/view/sections/sections.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockUrlShortenerCubit extends MockCubit<UrlShortenerState>
    implements UrlShortenerCubit {}

void main() {
  late MockUrlShortenerCubit _cubit;
  group('RecentUrlHeader', () {
    _cubit = MockUrlShortenerCubit();
    setUp(() {
      when(() => _cubit.state).thenReturn(
        UrlShortenerState.idle(recents: Stack()),
      );
    });
    testWidgets('renders correctly ', (tester) async {
      await tester.pumpAppWithDependencies(
        const RecentUrlHeader(),
        cubit: _cubit,
      );
      expect(find.text('Recent URLs'), findsOneWidget);
      expect(find.byType(SortActionButton), findsOneWidget);
    });

    testWidgets('recentUrlsSorted is called on sort tapped', (tester) async {
      await tester.pumpAppWithDependencies(
        const RecentUrlHeader(),
        cubit: _cubit,
      );
      await tester.tap(find.byType(SortActionButton));
      verify(_cubit.recentUrlsSorted).called(1);
    });
  });
}
