import 'package:google_home/src/home_feature/widget/models/plug_status.dart';
import 'package:google_home/src/home_feature/widget/models/responses/meter_response.dart';
import 'package:google_home/src/home_feature/widget/models/responses/relay_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plug_status_response.g.dart';

@JsonSerializable()
class PlugStatusResponse {
  List<RelayResponse> relays;
  List<MeterResponse> meters;
  double temperature;
  bool overtemperature;

  PlugStatusResponse({
    required this.relays,
    required this.meters,
    required this.temperature,
    required this.overtemperature,
  });

  factory PlugStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PlugStatusResponseFromJson(json);

  // Convert from Response to Model
  PlugStatus toPlugStatus() {
    return PlugStatus(
      relays: relays.map((relayResponse) => relayResponse.toRelay()).toList(),
      meters: meters.map((meterResponse) => meterResponse.toMeter()).toList(),
      temperature: temperature,
      overtemperature: overtemperature,
    );
  }
}
