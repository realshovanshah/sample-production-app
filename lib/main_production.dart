import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  final _urlShortenerRepository = UrlShortenerRepositoryImpl();
  bootstrap(
    () => App(urlShortenerRepository: _urlShortenerRepository),
  );
}
