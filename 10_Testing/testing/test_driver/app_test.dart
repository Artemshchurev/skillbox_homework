// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Login form tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    var emailField = find.byValueKey('loginEmail');
    var phoneField = find.byValueKey('loginPhone');
    var submitButton = find.byValueKey('loginSubmit');

    test('empty email and phone warnings', () async {
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Введите email'));
      await driver.waitFor(find.text('Введите телефон'));
    });

    test('wrong email and digital phone', () async {
      await driver.tap(emailField);
      await driver.enterText('eneibi232');
      await driver.tap(phoneField);
      await driver.enterText('123frfr5656');
      await driver.waitFor(find.text('1235656'));
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Поле email заполнено не корректно'));
    });

    test('correct data', () async {
      await driver.tap(emailField);
      await driver.enterText('artem@gmail.com');
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Добро пожаловать'));
    });
  });

  group('Rigister form tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    // TODO: write tests
  });
}
