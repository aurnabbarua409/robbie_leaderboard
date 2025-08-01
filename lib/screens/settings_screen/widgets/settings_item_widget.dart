import 'package:flutter/material.dart';
import 'package:the_leaderboard/widgets/icon_widget/icon_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const SettingsItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconWidget(
                  icon: icon,
                  color: AppColors.white,
                  height: 22,
                  width: 22,
                ),
                const SpaceWidget(spaceWidth: 8),
                TextWidget(
                  text: title,
                  fontColor: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
