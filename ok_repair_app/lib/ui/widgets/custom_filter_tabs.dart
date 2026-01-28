import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'custom_text.dart';

class FilterTabs extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;
  final Map<String, int> stats;

  const FilterTabs({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'all', 'label': 'All', 'count': stats['all'] ?? 0},
      {'key': 'pending', 'label': 'Pending', 'count': stats['pending'] ?? 0},
      {'key': 'repaired', 'label': 'Repaired', 'count': stats['repaired'] ?? 0},
      {'key': 'delivered', 'label': 'Delivered', 'count': stats['delivered'] ?? 0},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selectedFilter == filter['key'];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onFilterChanged(filter['key'] as String),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryDarkBlue : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppColors.primaryDarkBlue : AppColors.professionalSubtext.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      (filter['label'] as String).customText( // Type cast here
                        style: CustomTextStyle.bodyMedium,
                        color: isSelected ? Colors.white : AppColors.professionalText,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white.withOpacity(0.2) : AppColors.primaryDarkBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: '${filter['count']}'.customText(
                          style: CustomTextStyle.bodySmall,
                          color: isSelected ? Colors.white : AppColors.primaryDarkBlue,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}