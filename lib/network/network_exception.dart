import 'package:dio/dio.dart';

class NetworkException implements Exception {
  String message = '';
  NetworkException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        message = 'Request to server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        message = 'Connection Timedouy with server.';
        break;
      case DioErrorType.other:
        message = 'Request to server was cancelled.';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Received timout in connection with server.';
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with server.';
        break;
      case DioErrorType.response:
        message = _handleError(error.response?.statusCode);
        break;

      default:
        message = "Something went wrong.";
        break;
    }
  }

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 404:
        return 'Requested resource was not found.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
