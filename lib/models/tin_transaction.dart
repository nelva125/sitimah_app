class TinTransaction {
  final int? id;
  final DateTime date;
  final String supplierName;
  final double weightKg;
  final double pricePerKg; // Stored as double for calculation
  final String quality;
  final String? notes;

  TinTransaction({
    this.id,
    required this.date,
    required this.supplierName,
    required this.weightKg,
    required this.pricePerKg,
    required this.quality,
    this.notes,
  });

  // Calculate Total Price
  double get totalPrice => weightKg * pricePerKg;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'supplierName': supplierName,
      'weightKg': weightKg,
      'pricePerKg': pricePerKg,
      'quality': quality,
      'notes': notes,
    };
  }

  factory TinTransaction.fromMap(Map<String, dynamic> map) {
    return TinTransaction(
      id: map['id'],
      date: DateTime.parse(map['date']),
      supplierName: map['supplierName'],
      weightKg: map['weightKg'],
      pricePerKg: map['pricePerKg'],
      quality: map['quality'],
      notes: map['notes'],
    );
  }
}
