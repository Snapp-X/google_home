import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/core/services/http/http_service.dart';
import 'package:google_home/src/core/services/http/http_service_provider.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HomeRepository(httpService);
});

class HomeRepository {
  HomeRepository(this.httpService);

  final HttpService httpService;
}
