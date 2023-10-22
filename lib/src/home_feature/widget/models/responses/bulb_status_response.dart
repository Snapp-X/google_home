import 'package:google_home/src/home_feature/widget/models/bulb_status.dart';
import 'package:google_home/src/home_feature/widget/models/responses/light_response.dart';

import 'package:json_annotation/json_annotation.dart';

part 'bulb_status_response.g.dart';

@JsonSerializable()
class BulbStatusResponse {
  BulbStatusResponse({
    required this.lights,
  });

  factory BulbStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BulbStatusResponseFromJson(json);

  final List<LightResponse> lights;

  BulbStatus toBulbStatus() {
    return BulbStatus(
      //Convert from Response to Model
      lights: lights.map((light) => light.toLight()).toList(),
    );
  }
}
