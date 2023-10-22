import 'package:google_home/src/home_feature/widget/models/relay.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relay_response.g.dart';

@JsonSerializable()
class RelayResponse {
  bool ison;
  @JsonKey(name: 'has_timer')
  bool hasTimer;
  bool overpower;

  RelayResponse({
    required this.ison,
    required this.hasTimer,
    required this.overpower,
  });

  factory RelayResponse.fromJson(Map<String, dynamic> json) =>
      _$RelayResponseFromJson(json);

  Relay toRelay() {
    return Relay(
      ison: ison,
      hasTimer: hasTimer,
      overpower: overpower,
    );
  }
}
