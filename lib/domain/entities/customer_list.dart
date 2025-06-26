import 'package:gtr_assessment/domain/entities/customer.dart';

class CustomerList {
  final List<Customer> customers;
  final int totalCount;
  final int currentPage;
  final int pageSize;
  final bool hasNextPage;

  CustomerList({
    required this.customers,
    required this.totalCount,
    required this.currentPage,
    required this.pageSize,
    required this.hasNextPage,
  });
}
