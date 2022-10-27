// @dart=2.9

import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/locator.dart';
import 'package:pokedex/src/core/database/db_operations.dart';
import 'package:pokedex/src/core/repository/http_repo.dart';
import 'package:pokedex/src/services/general/networking_service.dart';

class DioAdapterMock extends Mock implements DefaultHttpClientAdapter {}

class MockDbOperations extends Mock implements DbOperations {}

class MockNetworkInfoService extends Mock implements NetworkInfoService {}

Future<ResponseBody> fakeResponse(Map<String, dynamic> body,
    [int statusCode = 200, dynamic headers = const [Headers.jsonContentType]]) async {
  final responsePayload = jsonEncode(body);
  return ResponseBody.fromString(
    responsePayload,
    statusCode,
    headers: {Headers.contentTypeHeader: headers},
  );
}

void basicMockService() async {
  await locator.reset();
  locator.registerSingleton<Dio>(Dio());
  locator.registerSingleton<NetworkInfoService>(MockNetworkInfoService());
  locator.registerSingleton<DbOperations>(MockDbOperations());

  locator.registerSingleton<HttpRepo>(HttpRepo());
  final dio = locator<Dio>();
  dio.httpClientAdapter = DioAdapterMock();
}

Future<ResponseBody> callDio() async {
  final dio = locator<Dio>();

  return dio.httpClientAdapter.fetch(captureAny, any, any);
}

RequestOptions verifyDioHaveBeenCalled({int capturedIndex = 0}) {
  return verify(callDio()).captured[0];
}
