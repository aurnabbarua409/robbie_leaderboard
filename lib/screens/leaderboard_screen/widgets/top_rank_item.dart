import 'package:flutter/material.dart';
import 'package:the_leaderboard/constants/app_urls.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/gradient_text_widget/gradient_text_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class TopRankedItem extends StatelessWidget {
  final String rankLabel;
  final String name;
  final String amount;
  final String image;
  final Color rankColor;
  final double avatarSize;
  final bool fromOnline;

  const TopRankedItem(
      {super.key,
      required this.rankLabel,
      required this.name,
      required this.amount,
      required this.image,
      required this.rankColor,
      required this.avatarSize,
      required this.fromOnline});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: rankColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: CircleAvatar(
                radius: avatarSize,
                backgroundImage: fromOnline
                    ? NetworkImage("${AppUrls.mainUrl}$image")
                    : AssetImage(image),
              ),
            ),
            Positioned(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: rankColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextWidget(
                  text: rankLabel,
                  fontColor: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        const SpaceWidget(spaceHeight: 8),
        TextWidget(
          text: name,
          fontColor: AppColors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        const SpaceWidget(spaceHeight: 4),
        GradientText(
          text: amount,
          fontWeight: FontWeight.w600,
          fontSize: 16,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
