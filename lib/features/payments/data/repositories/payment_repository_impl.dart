import '../../domain/entities/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  
  PaymentRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<List<Payment>> getPayments(String studentId) async {
    return await remoteDataSource.getPayments(studentId);
  }
  
  @override
  Future<Payment> getPaymentById(String paymentId) async {
    return await remoteDataSource.getPaymentById(paymentId);
  }
}
