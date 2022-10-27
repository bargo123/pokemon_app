import 'package:dio/dio.dart';
import 'package:pokedex/src/core/errors/exceptions.dart';
import 'package:pokedex/src/core/repository/interceptor.dart';
import 'package:pokedex/src/enums/http_enum.dart';
import 'package:pokedex/src/services/general/networking_service.dart';

import '../../../locator.dart';
import '../../enums/http_enum.dart';

class HttpRepo {
  final NetworkInfoService connectivity = locator<NetworkInfoService>();
  Future<dynamic> makeRequest(
      {required HttpRequestEnum requestType,
      required String methodName,
      Map<String, dynamic> getQueryParam = const {},
      Map<String, dynamic>? postBody,
      String contentType = Headers.jsonContentType}) async {
    if (await connectivity.isAvailable()) {
      Response? result;
      Dio dioClient = locator<Dio>();
      dioClient.options = BaseOptions(
          baseUrl: "https://pokeapi.co/api/v2/",
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return true;
          });
      dioClient.interceptors.add(HttpInterceptor());

      switch (requestType) {
        case HttpRequestEnum.GET:
          result = await dioClient.get(
            methodName,
            queryParameters: getQueryParam,
            options: Options(contentType: contentType),
          );
          break;
        case HttpRequestEnum.POST:
          break;
      }
      return result?.data;
    }
    throw ConnectionException(message: "Not Connected to any Network");
  }
}
