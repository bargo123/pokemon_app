import 'package:dio/dio.dart';

import '../errors/exceptions.dart';

class HttpInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      if (validateResponse(response)) {
        return handler.next(response);
      }
    } on DioError catch (error) {
      handler.reject(error);
    }
    super.onResponse(response, handler);
  }

  bool validateResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return true;
      case 401:
      case 403:
        throw DioError(
            error: HttpException(response.statusCode, 'Unauthorized Request'), requestOptions: response.requestOptions);
      case 400:
      case 404:
        throw DioError(error: BadRequestException("Bad Request", response.statusCode!), requestOptions: response.requestOptions);
      default:
        throw DioError(
            error: ServerError(
              response.statusCode!,
              'Error occurred while Communication with Server with StatusCode',
            ),
            requestOptions: response.requestOptions);
    }
  }
}
