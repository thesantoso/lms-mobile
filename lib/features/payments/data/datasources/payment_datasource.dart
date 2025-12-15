import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/payment_model.dart';

abstract class PaymentRemoteDataSource {
  Future<List<PaymentModel>> getPayments(String studentId);
  Future<PaymentModel> getPaymentById(String paymentId);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final DioClient client;
  
  PaymentRemoteDataSourceImpl(this.client);
  
  @override
  Future<List<PaymentModel>> getPayments(String studentId) async {
    final response = await client.get(
      ApiEndpoints.payments,
      queryParameters: {'studentId': studentId},
    );
    
    final List<dynamic> data = response.data as List<dynamic>;
    return data
        .map((json) => PaymentModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
  
  @override
  Future<PaymentModel> getPaymentById(String paymentId) async {
    final response = await client.get('${ApiEndpoints.payments}/$paymentId');
    return PaymentModel.fromJson(response.data as Map<String, dynamic>);
  }
}
