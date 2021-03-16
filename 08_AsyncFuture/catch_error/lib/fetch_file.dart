import 'package:flutter/services.dart';

Future<String> fetchFileFromAssets(String assetsPath) async {
  return Future.sync(() {
    return rootBundle
        .loadString(assetsPath)
        .then((file) => file.toString())
        .catchError((error) {
      print('inside catch error');
      return 'File not found';
    });
  }).catchError(() {
    print('inside sync future catch error');
    return 'File not found';
  });
}
