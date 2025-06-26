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
    const int maxVisiblePages = 5;

    if (totalPages <= maxVisiblePages) {
      return List.generate(totalPages, (index) => index + 1);
    }

    int start = currentPage - 2;
    int end = currentPage + 2;

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        if (currentPage > 1)
          navigationButton(
            icon: Icons.chevron_left,
            onPressed: () => onPageChanged(currentPage - 1),
          ),

        const SizedBox(width: 8),

        // First page if not visible
        if (visiblePages.first > 1) ...[
          pageBtn(1),
          if (visiblePages.first > 2) ellipsis(),
        ],

        // Visible page numbers
        ...visiblePages.map((page) => pageBtn(page)),

        // Last page if not visible
        if (visiblePages.last < totalPages) ...[
          if (visiblePages.last < totalPages - 1) ellipsis(),
          pageBtn(totalPages),
        ],

        const SizedBox(width: 8),

        // Next button
        if (currentPage < totalPages)
          navigationButton(
            icon: Icons.chevron_right,
            onPressed: () => onPageChanged(currentPage + 1),
          ),
      ],
    );
  }

  Widget pageBtn(int page) {
    final isCurrentPage = page == currentPage;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: isCurrentPage ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: isCurrentPage ? null : () => onPageChanged(page),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isCurrentPage ? Colors.blue : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppText(
              text: page.toString(),
              textfontsize: 14,
              fontWeight: isCurrentPage ? FontWeight.w600 : FontWeight.normal,
              color: isCurrentPage ? Colors.white : Colors.black87,
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
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Material(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 20, color: Colors.black87),
          ),
        ),
      ),
    );
  }

  Widget ellipsis() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: const AppText(text: '...', textfontsize: 14, color: Colors.grey),
    );
  }
}
