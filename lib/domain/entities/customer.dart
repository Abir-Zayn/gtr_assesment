class Customer {
  final int id;
  final String name;
  final String email;
  final String primaryAddress;
  final String? secondaryAddress;
  final String? notes;
  final String phone;
  final String custType;
  final String? parentCustomer;
  final String? imagePath;
  final double totalDue;
  final String lastSalesDate;
  final String lastInvoiceNo;
  final String lastSoldProduct;
  final double totalSalesValue;
  final double totalSalesReturnValue;
  final double totalAmountBack;
  final double totalCollection;
  final String lastTransactionDate;
  final String? clientCompanyName;

    const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.primaryAddress,
    this.secondaryAddress,
    this.notes,
    required this.phone,
    required this.custType,
    this.parentCustomer,
    this.imagePath,
    required this.totalDue,
    required this.lastSalesDate,
    required this.lastInvoiceNo,
    required this.lastSoldProduct,
    required this.totalSalesValue,
    required this.totalSalesReturnValue,
    required this.totalAmountBack,
    required this.totalCollection,
    required this.lastTransactionDate,
    this.clientCompanyName,
  });

  

}