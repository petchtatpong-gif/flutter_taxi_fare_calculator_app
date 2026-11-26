List<CalculationRecord> _history = [];

class CalculationRecord {
  final String id;
  final double distance;
  final double waitTime;
  final dynamic vehicleType;
  final double totalFare;
  final DateTime date;

  CalculationRecord({
    required this.id,
    required this.distance,
    required this.waitTime,
    required this.vehicleType,
    required this.totalFare,
    required this.date,
  });
}

void saveRecord(CalculationRecord record) {
  _history.insert(0, record);
}

List<CalculationRecord> getHistory() {
  return _history;
}
