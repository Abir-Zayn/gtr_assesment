import 'package:gtr_assessment/data/model/customer_model.dart';
import 'package:gtr_assessment/domain/entities/customer_list.dart';

class CustomerListModel extends CustomerList {
  CustomerListModel({
    required super.customers,
    required super.totalCount,
    required super.currentPage,
    required super.pageSize,
    required super.hasNextPage,
  });

  factory CustomerListModel.fromJson(
    List<dynamic> jsonList,
    int currentPage,
    int pageSize,
  ) {
    final customers =
        jsonList.map((json) => CustomerModel.fromJson(json)).toList();
    final totalCount = customers.length;
    final hasNextPage = customers.length >= pageSize;

    return CustomerListModel(
      customers: customers,
      totalCount: totalCount,
      currentPage: currentPage,
      pageSize: pageSize,
      hasNextPage: hasNextPage,
    );
  }

  factory CustomerListModel.fromJsonWithPagination(
    List<dynamic> jsonList,
    int currentPage,
    int pageSize,
    int totalCount,
    bool hasNextPage,
  ) {
    final customers =
        jsonList.map((json) => CustomerModel.fromJson(json)).toList();

    return CustomerListModel(
      customers: customers,
      totalCount: totalCount,
      currentPage: currentPage,
      pageSize: pageSize,
      hasNextPage: hasNextPage,
    );
  }
}
