import 'package:flutter/material.dart';
import 'package:the_leaderboard/constants/app_strings.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class LeaderboardDropdown extends StatelessWidget {
  final String value;
  final List<String> text;
  final ValueChanged<String?> onChanged;

  const LeaderboardDropdown({
    super.key,
    required this.value,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        dropdownColor: AppColors.blueDark,
        icon: const Icon(Icons.arrow_drop_down, color: AppColors.white),
        underline: const SizedBox(),
        items: text.map((String item) {
          String displayText;
          switch (item) {
            case 'Leaderboard':
              displayText = AppStrings.leaderboardText;
              break;
            case 'Event Leaderboard':
              displayText = AppStrings.eventLeaderboard;
              break;
            case 'Creator Leaderboard':
              displayText = AppStrings.creatorLeaderboard;
              break;
            default:
              displayText = item;
          }
          return DropdownMenuItem(
            value: item,
            child: TextWidget(
              text: displayText,
              fontColor: AppColors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
