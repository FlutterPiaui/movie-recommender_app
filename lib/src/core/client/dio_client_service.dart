import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:movie_recommender_app/src/core/client/api_client.dart';

class ApiClientDio implements ApiClient {
  final Dio _dio;

  ApiClientDio(this._dio) {
    _dio.options.baseUrl = 'https://api-l7ha4sjina-uc.a.run.app';
  }

  @override
  Future<ClientResponse> get({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(path,
          options: Options(headers: headers), queryParameters: queryParams);
      return ClientResponse(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } on DioException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<ClientResponse> post({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    ResponseType? responseType = ResponseType.json,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: Options(
          responseType: responseType,
          headers: headers,
        ),
      );
      return ClientResponse(
          data: response.data, statusCode: response.statusCode!);
    } on DioException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<ClientResponse> delete({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(path,
          data: data, options: Options(headers: headers));
      return ClientResponse(
          data: response.data, statusCode: response.statusCode!);
    } on DioException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<ClientResponse> patch({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(path,
          data: data, options: Options(headers: headers));
      return ClientResponse(
          data: response.data, statusCode: response.statusCode!);
    } on DioException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<ClientResponse> put({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response =
          await _dio.put(path, data: data, options: Options(headers: headers));
      return ClientResponse(
          data: response.data, statusCode: response.statusCode!);
    } on DioException catch (e, s) {
      log(e.toString());
      log(s.toString());
      throw HttpServiceError(message: e.toString(), stackTrace: s);
    }
  }
}
