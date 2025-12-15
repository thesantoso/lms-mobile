import '../../domain/entities/payment.dart';

class PaymentModel extends Payment {
  PaymentModel({
    required super.id,
    required super.studentId,
    required super.schoolId,
    required super.description,
    required super.amount,
    required super.status,
    required super.dueDate,
    super.paidDate,
  });
  
  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'] as String,
      studentId: json['studentId'] as String,
      schoolId: json['schoolId'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: PaymentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      dueDate: DateTime.parse(json['dueDate'] as String),
      paidDate: json['paidDate'] != null
          ? DateTime.parse(json['paidDate'] as String)
          : null,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentId': studentId,
      'schoolId': schoolId,
      'description': description,
      'amount': amount,
      'status': status.name,
      'dueDate': dueDate.toIso8601String(),
      'paidDate': paidDate?.toIso8601String(),
    };
  }
}
