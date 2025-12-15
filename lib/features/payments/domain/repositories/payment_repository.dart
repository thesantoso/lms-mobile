import '../entities/payment.dart';

abstract class PaymentRepository {
  Future<List<Payment>> getPayments(String studentId);
  Future<Payment> getPaymentById(String paymentId);
}
