import 'package:flutter/material.dart';
import 'package:gtr_assessment/domain/entities/customer.dart';

class CustomerDetailsPage extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header Card with Image and Basic Info
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          customer.imagePath != null
                              ? NetworkImage(
                                'https://www.pqstec.com/InvoiceApps/${customer.imagePath}',
                              )
                              : null,
                      child:
                          customer.imagePath == null
                              ? Text(
                                customer.name.isNotEmpty
                                    ? customer.name[0].toUpperCase()
                                    : 'C',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                              : null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      customer.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      customer.custType,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Contact Information
            _buildInfoCard('Contact Information', [
              _buildInfoRow('Email', customer.email, Icons.email),
              _buildInfoRow('Phone', customer.phone, Icons.phone),
              _buildInfoRow(
                'Primary Address',
                customer.primaryAddress,
                Icons.location_on,
              ),
              if (customer.secondaryAddress != null)
                _buildInfoRow(
                  'Secondary Address',
                  customer.secondaryAddress!,
                  Icons.location_on_outlined,
                ),
              if (customer.clientCompanyName != null)
                _buildInfoRow(
                  'Company',
                  customer.clientCompanyName!,
                  Icons.business,
                ),
            ]),

            const SizedBox(height: 16),

            // Financial Information
            _buildInfoCard('Financial Information', [
              _buildInfoRow(
                'Total Due',
                '\$${customer.totalDue.toStringAsFixed(2)}',
                Icons.account_balance_wallet,
              ),
              _buildInfoRow(
                'Total Sales Value',
                '\$${customer.totalSalesValue.toStringAsFixed(2)}',
                Icons.trending_up,
              ),
              _buildInfoRow(
                'Total Collection',
                '\$${customer.totalCollection.toStringAsFixed(2)}',
                Icons.savings,
              ),
              _buildInfoRow(
                'Total Sales Return',
                '\$${customer.totalSalesReturnValue.toStringAsFixed(2)}',
                Icons.trending_down,
              ),
              _buildInfoRow(
                'Total Amount Back',
                '\$${customer.totalAmountBack.toStringAsFixed(2)}',
                Icons.money_off,
              ),
            ]),

            const SizedBox(height: 16),

            // Transaction History
            _buildInfoCard('Transaction History', [
              _buildInfoRow(
                'Last Sales Date',
                customer.lastSalesDate.isEmpty ? 'N/A' : customer.lastSalesDate,
                Icons.calendar_today,
              ),
              _buildInfoRow(
                'Last Invoice No',
                customer.lastInvoiceNo.isEmpty ? 'N/A' : customer.lastInvoiceNo,
                Icons.receipt,
              ),
              _buildInfoRow(
                'Last Sold Product',
                customer.lastSoldProduct.isEmpty
                    ? 'N/A'
                    : customer.lastSoldProduct,
                Icons.shopping_cart,
              ),
              _buildInfoRow(
                'Last Transaction Date',
                customer.lastTransactionDate,
                Icons.access_time,
              ),
            ]),

            const SizedBox(height: 16),

            // Additional Information
            if (customer.notes != null || customer.parentCustomer != null)
              _buildInfoCard('Additional Information', [
                if (customer.parentCustomer != null)
                  _buildInfoRow(
                    'Parent Customer',
                    customer.parentCustomer!,
                    Icons.person_outline,
                  ),
                if (customer.notes != null)
                  _buildInfoRow('Notes', customer.notes!, Icons.note),
              ]),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
