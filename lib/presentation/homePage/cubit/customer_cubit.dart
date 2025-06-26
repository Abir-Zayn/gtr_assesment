import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtr_assessment/domain/entities/customer_list.dart';
import 'package:gtr_assessment/domain/usecase/customer_list_usecase.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final CustomerListUsecase customerListUsecase;

  CustomerCubit(this.customerListUsecase) : super(CustomerInitial());

  Future<void> loadCustomerList({
    String searchQuery = '',
    int pageNo = 1,
    int pageSize = 15, // Changed default to 15
    String sortBy = 'Balance',
    required String token,
  }) async {
    try {
      emit(CustomerLoading());

      debugPrint(
        'Loading customers - Page: $pageNo, Query: $searchQuery',
      ); // Debug log

      final result = await customerListUsecase.call(
        searchQuery: searchQuery,
        pageNo: pageNo,
        pageSize: pageSize,
        sortBy: sortBy,
        token: token,
      );

      result.fold(
        (error) {
          debugPrint('Customer error: $error'); // Debug log
          emit(CustomerError(error));
        },
        (customerList) {
          debugPrint(
            'Customer loaded: ${customerList.customers.length} items',
          ); // Debug log
          emit(CustomerLoaded(customerList));
        },
      );
    } catch (e) {
      debugPrint('Unexpected error in CustomerCubit: $e'); // Debug log
      emit(CustomerError('Unexpected error: $e'));
    }
  }

  void resetState() {
    emit(CustomerInitial());
  }
}
