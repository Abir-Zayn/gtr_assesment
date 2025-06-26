import 'package:dartz/dartz.dart';
import 'package:gtr_assessment/domain/entities/customer_list.dart';
import 'package:gtr_assessment/domain/repositories/customer_repository.dart';

class CustomerListUsecase {
  final CustomerRepository repo;

  const CustomerListUsecase(this.repo);

  Future<Either<String, CustomerList>> call({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  }) async {
    return await repo.getCustomerList(
      searchQuery: searchQuery,
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      token: token,
    );
  }
}
