#!/usr/bin/zsh

echo "Running tests in root dir..."
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/

echo "\nRunning tests in equatable_stack..."
cd packages/equatable_stack
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/


echo "\nRunning tests in url_shortener_api..."
cd ../url_shortener_api
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/


echo "\nRunning tests in url_shortener_repository..."
cd ../url_shortener_repository
flutter test --coverage --test-randomize-ordering-seed random
genhtml coverage/lcov.info -o coverage/
