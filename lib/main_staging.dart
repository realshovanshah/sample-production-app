import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  // swap to a mock implementation for development
  final _urlShortenerRepository = UrlShortenerRepositoryImpl(
    // todo: create a default implementation
    urlShortenerLocalApi: UrlShortenerLocalApi(hive: Hive),
    urlShortenerRemoteApi: UrlShortenerRemoteApi(),
  );
  bootstrap(
    () => App(urlShortenerRepository: _urlShortenerRepository),
  );
}
