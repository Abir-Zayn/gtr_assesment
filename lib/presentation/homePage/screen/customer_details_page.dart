import 'package:flutter/material.dart';
import 'package:gtr_assessment/common/components/app_text.dart';
import 'package:gtr_assessment/domain/entities/customer.dart';

class CustomerDetailsPage extends StatelessWidget {
  final Customer customer;

  const CustomerDetailsPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Header
            customerDetailsHead(),

            const SizedBox(height: 24),

            // Customer Details
            sectionData('Contact', [
              details('Email', customer.email),
              details('Phone', customer.phone),
              details('Address', customer.primaryAddress),
            ], context),

            sectionData('Financial', [
              details('Total Due', '\$${customer.totalDue.toStringAsFixed(2)}'),
              details(
                'Total Sales',
                '\$${customer.totalSalesValue.toStringAsFixed(2)}',
              ),
              details(
                'Total Collection',
                '\$${customer.totalCollection.toStringAsFixed(2)}',
              ),
            ], context),

            sectionData('Recent Activity', [
              details(
                'Last Sales Date',
                customer.lastSalesDate.isEmpty ? 'N/A' : customer.lastSalesDate,
              ),
              details(
                'Last Invoice',
                customer.lastInvoiceNo.isEmpty ? 'N/A' : customer.lastInvoiceNo,
              ),
              details(
                'Last Product',
                customer.lastSoldProduct.isEmpty
                    ? 'N/A'
                    : customer.lastSoldProduct,
              ),
            ], context),
          ],
        ),
      ),
    );
  }

  Widget customerDetailsHead() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
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
                          : 'Null',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    : null,
          ),
          const SizedBox(height: 12),
          AppText(
            text: customer.name,
            textfontsize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
          const SizedBox(height: 8),
          AppText(
            text: customer.custType,
            textfontsize: 18,
            color: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }

  Widget sectionData(
    String title,
    List<Widget> children,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          textfontsize: 20,
          color: Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black,
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(children: children),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget details(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
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
