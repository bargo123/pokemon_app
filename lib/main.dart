import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';

import 'app.dart';
import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runZonedGuarded(() {
    runApp(const App());
  }, (error, stack) {
    if (error is DioError) {
      final exception = error.error;
      if (exception is HttpException) {
        ScaffoldMessenger.of(navKey.currentContext!)
            .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(exception.message!)));
      } else if (exception is BadRequestException) {
        ScaffoldMessenger.of(navKey.currentContext!)
            .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(error.message)));
      }
    } else if (error is ConnectionException) {
      ScaffoldMessenger.of(navKey.currentContext!)
          .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(error.message!)));
    } else if (error is DataBaseException) {
      ScaffoldMessenger.of(navKey.currentContext!)
          .showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(error.message)));
    }
  });
}
