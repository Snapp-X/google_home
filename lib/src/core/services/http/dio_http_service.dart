import 'package:dio/dio.dart';
import 'package:google_home/src/core/services/http/http_service.dart';

/// Http service implementation using the Dio package
///
/// See https://pub.dev/packages/dio
class DioHttpService implements HttpService {
  /// Creates new instance of [DioHttpService]
  DioHttpService({
    Dio? dioOverride,
  }) {
    dio = dioOverride ?? Dio(baseOptions);
  }

  /// The Dio Http client
  late final Dio dio;

  /// The Dio base options
  BaseOptions get baseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => '';

  @override
  Map<String, String> headers = {
    'accept': 'application/json',
    'content-type': 'application/json'
  };

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
    String? customBaseUrl,
  }) async {
    final Response<dynamic> response = await dio.get<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );

    return response.data as Map<String, dynamic>;
  }

  @override
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final Response<dynamic> response = await dio.post<Map<String, dynamic>>(
      endpoint,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  @override
  Future<dynamic> delete() {
    throw UnimplementedError();
  }

  @override
  Future<dynamic> put() {
    throw UnimplementedError();
  }
}
