import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/core/services/http/dio_http_service.dart';
import 'package:google_home/src/core/services/http/http_service.dart';

/// Provider that maps an [HttpService] interface to implementation
final httpServiceProvider = Provider<HttpService>((ref) {
  return DioHttpService();
});
