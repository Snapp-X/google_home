import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_home/src/core/services/http/http_service.dart';
import 'package:google_home/src/core/services/http/http_service_provider.dart';
import 'package:google_home/src/home_feature/widget/models/bulb_status.dart';
import 'package:google_home/src/home_feature/widget/models/light.dart';
import 'package:google_home/src/home_feature/widget/models/responses/bulb_status_response.dart';
import 'package:google_home/src/home_feature/widget/models/responses/light_response.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);

  return HomeRepository(httpService);
});

typedef BulbStatusEither = Either<Exception, BulbStatus>;
typedef LightEither = Either<Exception, Light>;

const bulbUrl = 'http://192.168.1.101';
const plugUrl = 'http://192.168.1.100';

class HomeRepository {
  HomeRepository(this.httpService);

  final HttpService httpService;

  Future<BulbStatusEither> getBulbStatus() async {
    try {
      final response = await httpService.get('$bulbUrl/status');

      final bulbStatus = BulbStatusResponse.fromJson(
        response,
      ).toBulbStatus();
      return right(
        bulbStatus,
      );
    } on DioException catch (error) {
      return left(error);
    }
  }

  Future<LightEither> setBulb(bool on) async {
    final turn = on ? 'on' : 'off';
    try {
      final response = await httpService.get('$bulbUrl/color/0?turn=$turn');

      final light = LightResponse.fromJson(
        response,
      ).toLight();
      return right(
        light,
      );
    } on DioException catch (error) {
      return left(error);
    }
  }

  Future<LightEither> setBulbColor(Color color) async {
    try {
      final response = await httpService.get(
          '$bulbUrl/color/0?turn=on&red=${color.red}&green=${color.green}&blue=${color.blue}&white=0');

      final light = LightResponse.fromJson(
        response,
      ).toLight();
      return right(
        light,
      );
    } on DioException catch (error) {
      return left(error);
    }
  }

  Future<LightEither> setBulbBrightness(int brightness) async {
    int gain;
    if (brightness > 100) {
      gain = 100;
    } else if (brightness < 0) {
      gain = 0;
    } else {
      gain = brightness;
    }

    try {
      final response =
          await httpService.get('$bulbUrl/color/0?turn=on&gain=$gain');

      final light = LightResponse.fromJson(
        response,
      ).toLight();
      return right(
        light,
      );
    } on DioException catch (error) {
      return left(error);
    }
  }
}
