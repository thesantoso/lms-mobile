class Payment {
  final String id;
  final String studentId;
  final String schoolId;
  final String description;
  final double amount;
  final PaymentStatus status;
  final DateTime dueDate;
  final DateTime? paidDate;
  
  Payment({
    required this.id,
    required this.studentId,
    required this.schoolId,
    required this.description,
    required this.amount,
    required this.status,
    required this.dueDate,
    this.paidDate,
  });
  
  bool get isOverdue =>
      status != PaymentStatus.paid && DateTime.now().isAfter(dueDate);
}

enum PaymentStatus {
  pending,
  paid,
  overdue,
  cancelled;
  
  String get value => name;
}
