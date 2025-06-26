import 'package:dartz/dartz.dart';
import 'package:gtr_assessment/domain/entities/customer_list.dart';

abstract class CustomerRepository {
  Future<Either<String, CustomerList>> getCustomerList({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  });
}
