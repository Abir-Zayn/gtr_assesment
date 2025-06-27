import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gtr_assessment/data/src/customer_data_src.dart';
import 'package:gtr_assessment/domain/entities/customer_list.dart';
import 'package:gtr_assessment/domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final CustomerDataSrc dataSrc;

  CustomerRepositoryImpl({required this.dataSrc});

  @override
  Future<Either<String, CustomerList>> getCustomerList({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  }) async {
    try {
      debugPrint('Repository calling data source with token: $token'); 

      final response = await dataSrc.getCustomerList(
        searchQuery: searchQuery,
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        token: token,
      );

      debugPrint(
        'Repository received response with ${response.customers.length} customers',
      );
      return Right(response);
    } catch (e) {
      debugPrint('Repository error: $e'); // Debug log

      // Provide more specific error messages
      if (e.toString().contains('Authentication failed')) {
        return Left('Authentication failed. Please login again.');
      } else if (e.toString().contains('Network connection error')) {
        return Left(
          'Network connection error. Please check your internet connection.',
        );
      } else {
        return Left(e.toString());
      }
    }
  }
}
