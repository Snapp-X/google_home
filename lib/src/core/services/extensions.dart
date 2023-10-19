extension DateTimeFormatter on DateTime {
  String toDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
  }

  String toTimeString() {
    // ignore: lines_longer_than_80_chars
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
