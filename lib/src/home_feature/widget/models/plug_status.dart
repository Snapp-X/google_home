import 'package:google_home/src/home_feature/widget/models/meter.dart';
import 'package:google_home/src/home_feature/widget/models/relay.dart';

class PlugStatus {
  List<Relay> relays;
  List<Meter> meters;
  double temperature;
  bool overtemperature;

  PlugStatus({
    required this.relays,
    required this.meters,
    required this.temperature,
    required this.overtemperature,
  });
}
