part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerLoadingMore extends CustomerState{}

class CustomerLoaded extends CustomerState {
  final CustomerList customerList;
  const CustomerLoaded(this.customerList);
}

class CustomerError extends CustomerState {
  final String message;
  const CustomerError(this.message);
}
