import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_leaderboard/widgets/shimmer_loading_widget/shimmer_loading.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/gradient_text_widget/gradient_text_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';

class AffiliateStatusWidget extends StatelessWidget {
  final String totalRaisedValue;
  final String positionValue;
  final String profileViewValue;
  final VoidCallback iconButtonOnTap;
  final String codeNumber;
  final bool isLoading;

  const AffiliateStatusWidget(
      {super.key,
      required this.totalRaisedValue,
      required this.positionValue,
      required this.profileViewValue,
      required this.iconButtonOnTap,
      required this.codeNumber,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            text: "Affiliate Status",
            fontColor: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          const SpaceWidget(spaceHeight: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.blueDarker,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const TextWidget(
                        text: "Total Spent",
                        fontColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      const SpaceWidget(spaceHeight: 4),
                      isLoading
                          ? const ShimmerLoading(width: 100, height: 20)
                          : GradientText(
                              text: totalRaisedValue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                    ],
                  ),
                ),
              ),
              const SpaceWidget(spaceWidth: 6),
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.blueDarker,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const TextWidget(
                        text: "Position",
                        fontColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      const SpaceWidget(spaceHeight: 4),
                      isLoading
                          ? const ShimmerLoading(width: 100, height: 20)
                          : GradientText(
                              text: positionValue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                    ],
                  ),
                ),
              ),
              const SpaceWidget(spaceWidth: 6),
              Expanded(
                flex: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.blueDarker,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const TextWidget(
                        text: "Profile View",
                        fontColor: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      const SpaceWidget(spaceHeight: 4),
                      isLoading
                          ? const ShimmerLoading(width: 100, height: 20)
                          : GradientText(
                              text: profileViewValue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SpaceWidget(spaceHeight: 8),
          // Creator Code
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.blueDarker,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TextWidget(
                  text: "Creator Code",
                  fontColor: AppColors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: AppColors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: codeNumber));
                        iconButtonOnTap();
                      },
                    ),
                    isLoading
                        ? const ShimmerLoading(width: 100, height: 25)
                        : GradientText(
                            text: codeNumber,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
