import 'package:flutter_driver/driver_extension.dart';
import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/bootstrap.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

void main() {
  enableFlutterDriverExtension();
  const _urlShortenerRepository = FakeUrlShortenerRepositoryImpl();
  bootstrap(
    () => const App(urlShortenerRepository: _urlShortenerRepository),
  );
}
