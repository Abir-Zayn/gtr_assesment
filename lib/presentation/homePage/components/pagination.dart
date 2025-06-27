import 'package:flutter/material.dart';
import 'package:gtr_assessment/common/components/app_text.dart';

class Pagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const Pagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  List<int> visiblePagesNo() {
    // Reduce max visible pages for mobile screens
    const int maxVisiblePages = 3;

    if (totalPages <= maxVisiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    }

    int start = currentPage - 1;
    int end = currentPage + 1;

    if (start < 1) {
      start = 1;
      end = maxVisiblePages;
    } else if (end > totalPages) {
      start = totalPages - maxVisiblePages + 1;
      end = totalPages;
    }

    return List.generate(end - start + 1, (index) => start + index);
  }

  @override
  Widget build(BuildContext context) {
    final visiblePages = visiblePagesNo();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          if (currentPage > 1)
            navigationButton(
              icon: Icons.chevron_left,
              onPressed: () => onPageChanged(currentPage - 1),
            ),

          const SizedBox(width: 4),

          // First page if not visible
          if (visiblePages.first > 1) ...[
            pageBtn(1, context),
            if (visiblePages.first > 2) ellipsis(),
          ],

          // Visible page numbers
          ...visiblePages.map((page) => pageBtn(page, context)),

          // Last page if not visible
          if (visiblePages.last < totalPages) ...[
            if (visiblePages.last < totalPages - 1) ellipsis(),
            pageBtn(totalPages, context),
          ],

          const SizedBox(width: 4),

          // Next button
          if (currentPage < totalPages)
            navigationButton(
              icon: Icons.chevron_right,
              onPressed: () => onPageChanged(currentPage + 1),
            ),
        ],
      ),
    );
  }

  Widget pageBtn(int page, BuildContext context) {
    final isCurrentPage = page == currentPage;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
        color: isCurrentPage ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: isCurrentPage ? null : () => onPageChanged(page),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(
                color: isCurrentPage ? Colors.blue : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: AppText(
              text: page.toString(),
              textfontsize: 12,
              fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.normal,
              color:
                  isCurrentPage ? Theme.of(context).primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget navigationButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.all(6),
            child: Icon(icon, size: 16, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget ellipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: const AppText(text: '...', textfontsize: 12, color: Colors.grey),
    );
  }
}
