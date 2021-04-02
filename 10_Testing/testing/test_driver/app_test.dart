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

  group('Register form tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });


    var firstNameField = find.byValueKey('registerFirstName');
    var lastNameField = find.byValueKey('registerLastName');
    var phoneField = find.byValueKey('registerPhone');
    var emailField = find.byValueKey('registerEmail');
    var submitButton = find.byValueKey('registerSubmit');

    test('screen switch', () async {
      var loginEmailField = find.byValueKey('loginEmail');
      var switchButton = find.byValueKey('screenSwitch');
      await driver.tap(switchButton);
      await driver.waitFor(firstNameField);
      await driver.tap(switchButton);
      await driver.waitFor(loginEmailField);
      await driver.tap(switchButton);
      await driver.waitFor(firstNameField);
    });

    test('empty fields', () async {
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Введите имя'));
      await driver.waitFor(find.text('Введите фамилию'));
      await driver.waitFor(find.text('Заполните поле телефон'));
      await driver.waitFor(find.text('Заполните поле email'));
    });

    test('phone is digital', () async {
      await driver.tap(phoneField);
      await driver.enterText('123frfr5656');
      await driver.waitFor(find.text('1235656'));
    });

    test('you are successfully registered', () async {
      await driver.tap(firstNameField);
      await driver.enterText('Artem');
      await driver.tap(lastNameField);
      await driver.enterText('Shchurev');
      await driver.tap(emailField);
      await driver.enterText('artem@mail.ru');
      await driver.tap(submitButton);
      await driver.waitFor(find.text('Вы успешно зарегистрировались'));
    });
  });
}
