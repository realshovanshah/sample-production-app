import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  final _urlShortenerRepository = UrlShortenerRepositoryImpl(
    urlShortenerLocalApi: UrlShortenerLocalApi(hive: Hive),
    urlShortenerRemoteApi: UrlShortenerRemoteApi(),
  );
  bootstrap(
    () => App(urlShortenerRepository: _urlShortenerRepository),
  );
}
