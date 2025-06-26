import 'package:gtr_assessment/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.primaryAddress,
    super.secondaryAddress,
    super.notes,
    required super.phone,
    required super.custType,
    super.parentCustomer,
    super.imagePath,
    required super.totalDue,
    required super.lastSalesDate,
    required super.lastInvoiceNo,
    required super.lastSoldProduct,
    required super.totalSalesValue,
    required super.totalSalesReturnValue,
    required super.totalAmountBack,
    required super.totalCollection,
    required super.lastTransactionDate,
    super.clientCompanyName,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['Id'] ?? 0,
      name: json['Name'] ?? '',
      email: json['Email'] ?? '',
      primaryAddress: json['PrimaryAddress'] ?? '',
      secondaryAddress: json['SecoundaryAddress'],
      notes: json['Notes'],
      phone: json['Phone'] ?? '',
      custType: json['CustType'] ?? '',
      parentCustomer: json['ParentCustomer'],
      imagePath: json['ImagePath'],
      totalDue: (json['TotalDue'] ?? 0.0).toDouble(),
      lastSalesDate: json['LastSalesDate'] ?? '',
      lastInvoiceNo: json['LastInvoiceNo'] ?? '',
      lastSoldProduct: json['LastSoldProduct'] ?? '',
      totalSalesValue: (json['TotalSalesValue'] ?? 0.0).toDouble(),
      totalSalesReturnValue: (json['TotalSalesReturnValue'] ?? 0.0).toDouble(),
      totalAmountBack: (json['TotalAmountBack'] ?? 0.0).toDouble(),
      totalCollection: (json['TotalCollection'] ?? 0.0).toDouble(),
      lastTransactionDate: json['LastTransactionDate'] ?? '',
      clientCompanyName: json['ClinetCompanyName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Email': email,
      'PrimaryAddress': primaryAddress,
      'SecoundaryAddress': secondaryAddress,
      'Notes': notes,
      'Phone': phone,
      'CustType': custType,
      'ParentCustomer': parentCustomer,
      'ImagePath': imagePath,
      'TotalDue': totalDue,
      'LastSalesDate': lastSalesDate,
      'LastInvoiceNo': lastInvoiceNo,
      'LastSoldProduct': lastSoldProduct,
      'TotalSalesValue': totalSalesValue,
      'TotalSalesReturnValue': totalSalesReturnValue,
      'TotalAmountBack': totalAmountBack,
      'TotalCollection': totalCollection,
      'LastTransactionDate': lastTransactionDate,
      'ClinetCompanyName': clientCompanyName,
    };
  }
}