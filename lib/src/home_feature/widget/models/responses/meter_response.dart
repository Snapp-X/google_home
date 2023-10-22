import 'package:google_home/src/home_feature/widget/models/meter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meter_response.g.dart';

@JsonSerializable()
class MeterResponse {
  double power;
  @JsonKey(name: 'is_valid')
  bool isValid;
  int timestamp;
  List<double> counters;
  int total;

  MeterResponse({
    required this.power,
    required this.isValid,
    required this.timestamp,
    required this.counters,
    required this.total,
  });

  factory MeterResponse.fromJson(Map<String, dynamic> json) =>
      _$MeterResponseFromJson(json);

  Meter toMeter() {
    return Meter(
      power: power,
      isValid: isValid,
      timestamp: timestamp,
      counters: counters,
      total: total,
    );
  }
}
