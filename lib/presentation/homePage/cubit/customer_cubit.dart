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
    int pageSize = 20,
    String sortBy = 'Balance',
    required String token,
  }) async {
    try {
      if (pageNo == 1) {
        emit(CustomerLoading());
      } else {
        emit(CustomerLoadingMore());
      }

      debugPrint('Loading customers - Page: $pageNo, Query: $searchQuery'); // Debug log

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
          debugPrint('Customer loaded: ${customerList.customers.length} items'); // Debug log
          
          if (pageNo == 1) {
            emit(CustomerLoaded(customerList));
          } else {
            // Handle pagination - append to existing list
            if (state is CustomerLoaded) {
              final currentState = state as CustomerLoaded;
              final updatedCustomers = [
                ...currentState.customerList.customers,
                ...customerList.customers,
              ];
              
              final updatedCustomerList = CustomerList(
                customers: updatedCustomers,
                totalCount: customerList.totalCount,
                currentPage: customerList.currentPage,
                pageSize: customerList.pageSize,
                hasNextPage: customerList.hasNextPage,
              );
              
              emit(CustomerLoaded(updatedCustomerList));
            } else {
              emit(CustomerLoaded(customerList));
            }
          }
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