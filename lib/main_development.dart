import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  // swap to a mock implementation for development
  final _urlShortenerRepository = UrlShortenerRepositoryImpl();
  bootstrap(
    () => App(urlShortenerRepository: _urlShortenerRepository),
  );
}
