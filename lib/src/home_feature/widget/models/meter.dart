class Meter {
  double power;
  bool isValid;
  int timestamp;
  List<double> counters;
  int total;

  Meter({
    required this.power,
    required this.isValid,
    required this.timestamp,
    required this.counters,
    required this.total,
  });
}
