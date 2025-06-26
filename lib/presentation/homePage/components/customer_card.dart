import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr_assessment/common/components/app_text.dart';
import 'package:gtr_assessment/domain/entities/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;

  const CustomerCard({super.key, required this.customer});

  //Showing the customer list into the customer card widget. 

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Customer Image
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: customer.imagePath != null
                      ? NetworkImage(
                          'https://www.pqstec.com/InvoiceApps/${customer.imagePath}',
                        )
                      : null,
                  child: customer.imagePath == null
                      ? AppText(
                          text: customer.name.isNotEmpty
                              ? customer.name[0].toUpperCase()
                              : 'C',
                          textfontsize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Customer Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: customer.name,
                        textfontsize: 16,
                        fontWeight: FontWeight.w600,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        text: customer.email,
                        textfontsize: 14,
                        color: Colors.grey[600],
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      AppText(
                        text: customer.phone,
                        textfontsize: 14,
                        color: Colors.grey[600],
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Show More Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/customer-details', extra: customer);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const AppText(
                  text: 'Show More',
                  textfontsize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}