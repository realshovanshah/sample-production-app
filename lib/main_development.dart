import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  // swap to a mock implementation for development
  const _urlShortenerRepository = FakeUrlShortenerRepositoryImpl();
  bootstrap(
    () => const App(urlShortenerRepository: _urlShortenerRepository),
  );
}
