import 'package:equatable/equatable.dart';
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
    int pageSize = 15,
    String sortBy = 'Balance',
    required String token,
  }) async {
    emit(CustomerLoading());

    final result = await customerListUsecase.call(
      searchQuery: searchQuery,
      pageNo: pageNo,
      pageSize: pageSize,
      sortBy: sortBy,
      token: token,
    );

    result.fold(
      (error) => emit(CustomerError(error)),
      (customerList) => emit(CustomerLoaded(customerList)),
    );
  }

  void resetState() => emit(CustomerInitial());
}
