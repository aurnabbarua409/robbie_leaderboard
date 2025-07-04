import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:the_leaderboard/constants/app_icon_path.dart';
import 'package:the_leaderboard/screens/leaderboard_screen/widgets/leaderboard_dropdown.dart';
import 'package:the_leaderboard/screens/leaderboard_screen/widgets/leaderboard_item.dart';
import 'package:the_leaderboard/screens/leaderboard_screen/widgets/leaderboard_tabbar.dart';
import 'package:the_leaderboard/screens/leaderboard_screen/widgets/top_rank_item.dart';
import 'package:the_leaderboard/widgets/space_widget/space_widget.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_image_path.dart';
import '../../routes/app_routes.dart';
import '../../widgets/icon_widget/icon_widget.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  String selectedLeaderboard = 'Leaderboard';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Data for Leaderboard (All Time, Daily, Monthly)
  final List<Map<String, dynamic>> allTimeData = [
    {
      'rank': 4,
      'name': 'Cameron Williamson',
      'amount': '\$1,123',
      'isUp': false,
      'image': AppImagePath.userImage1
    },
    {
      'rank': 5,
      'name': 'Wade Warren',
      'amount': '\$1,123',
      'isUp': false,
      'image': AppImagePath.userImage2
    },
    {
      'rank': 6,
      'name': 'Brooklyn Simmons',
      'amount': '\$1,123',
      'isUp': false,
      'image': AppImagePath.userImage1
    },
    {
      'rank': 7,
      'name': 'Leslie Alexander',
      'amount': '\$1,123',
      'isUp': true,
      'image': AppImagePath.userImage2
    },
  ];

  final List<Map<String, dynamic>> allTimeTop3 = [
    {
      'rankLabel': '2nd Ranked',
      'name': 'Annamika',
      'amount': '\$2,323',
      'rankColor': Colors.grey,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked2
    },
    {
      'rankLabel': '1st Ranked',
      'name': 'Beaumorison',
      'amount': '\$3,323',
      'rankColor': AppColors.yellow,
      'avatarSize': 55.0,
      'image': AppImagePath.topRanked1
    },
    {
      'rankLabel': '3rd Ranked',
      'name': 'Wong Tou',
      'amount': '\$1,323',
      'rankColor': Colors.orange,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked3
    },
  ];

  // Data for Event Leaderboard (All Time, Daily, Monthly)
  final List<Map<String, dynamic>> eventAllTimeData = [
    {
      'rank': 3,
      'name': 'Event User 1',
      'amount': '\$1,500',
      'isUp': true,
      'image': AppImagePath.userImage1
    },
    {
      'rank': 3,
      'name': 'Event User 2',
      'amount': '\$1,400',
      'isUp': false,
      'image': AppImagePath.userImage2
    },
  ];

  final List<Map<String, dynamic>> eventAllTimeTop3 = [
    {
      'rankLabel': '2nd Ranked',
      'name': 'Event User 2',
      'amount': '\$1,600',
      'rankColor': Colors.grey,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked2
    },
    {
      'rankLabel': '1st Ranked',
      'name': 'Event User 1',
      'amount': '\$1,800',
      'rankColor': AppColors.yellow,
      'avatarSize': 50.0,
      'image': AppImagePath.topRanked1
    },
    {
      'rankLabel': '3rd Ranked',
      'name': 'Event User 3',
      'amount': '\$1,300',
      'rankColor': Colors.orange,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked3
    },
  ];

  final List<Map<String, dynamic>> creatorAllTimeData = [
    {
      'rank': 7,
      'name': 'Creator User 1',
      'amount': '\$2,200',
      'isUp': true,
      'image': AppImagePath.userImage1
    },
    {
      'rank': 7,
      'name': 'Creator User 2',
      'amount': '\$2,100',
      'isUp': false,
      'image': AppImagePath.userImage2
    },
  ];

  final List<Map<String, dynamic>> creatorAllTimeTop3 = [
    {
      'rankLabel': '2nd Ranked',
      'name': 'Creator User 2',
      'amount': '\$2,300',
      'rankColor': Colors.grey,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked2
    },
    {
      'rankLabel': '1st Ranked',
      'name': 'Creator User 1',
      'amount': '\$2,500',
      'rankColor': AppColors.yellow,
      'avatarSize': 50.0,
      'image': AppImagePath.topRanked1
    },
    {
      'rankLabel': '3rd Ranked',
      'name': 'Creator User 3',
      'amount': '\$2,000',
      'rankColor': Colors.orange,
      'avatarSize': 40.0,
      'image': AppImagePath.topRanked3
    },
  ];

  Widget buildLeaderboardTabView({
    required List<Map<String, dynamic>> top3Data,
    required List<Map<String, dynamic>> leaderboardData,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SpaceWidget(spaceHeight: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: top3Data.map((data) {
                return Transform.translate(
                  offset: data['rankLabel'] == '1st Ranked'
                      ? const Offset(0, -10)
                      : Offset.zero,
                  child: TopRankedItem(
                    rankLabel: data['rankLabel'],
                    name: data['name'],
                    amount: data['amount'],
                    rankColor: data['rankColor'],
                    avatarSize: data['avatarSize'],
                    image: data['image'],
                  ),
                );
              }).toList(),
            ),
          ),
          ...List.generate(
            leaderboardData.length,
            (index) {
              print('Building LeaderboardItem at index: $index');
              final data = leaderboardData[index];
              return LeaderboardItem(
                key: ValueKey('${data['name']}${data['rank']}$index'),
                rank: data['rank'],
                name: data['name'],
                amount: data['amount'],
                isUp: data['isUp'],
                image: data['image'],
                onPressed: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.blueDark,
        body: SafeArea(
          child: Column(
            children: [
              const SpaceWidget(spaceHeight: 16),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dropdown Button
                    LeaderboardDropdown(
                      value: selectedLeaderboard,
                      text: const [
                        'Leaderboard',
                        'Event Leaderboard',
                        'Creator Leaderboard',
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedLeaderboard = value!;
                          _tabController.index = 0;
                        });
                      },
                    ),
                    // Search Icon
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.searchScreen);
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.white.withOpacity(0.15),
                        child: const IconWidget(
                          height: 22,
                          width: 22,
                          icon: AppIconPath.searchIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Replaced TabBar with LeaderboardTabBar
              LeaderboardTabBar(
                tabTexts: const ['All Time', 'Daily', 'Monthly'],
                tabController: _tabController,
              ),

              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // All Time Tab
                    if (selectedLeaderboard == 'Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: allTimeTop3, leaderboardData: allTimeData)
                    else if (selectedLeaderboard == 'Event Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: eventAllTimeTop3,
                          leaderboardData: eventAllTimeData)
                    else
                      buildLeaderboardTabView(
                          top3Data: creatorAllTimeTop3,
                          leaderboardData: creatorAllTimeData),
                    // Daily Tab
                    if (selectedLeaderboard == 'Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: allTimeTop3, leaderboardData: allTimeData)
                    else if (selectedLeaderboard == 'Event Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: eventAllTimeTop3,
                          leaderboardData: eventAllTimeData)
                    else
                      buildLeaderboardTabView(
                          top3Data: creatorAllTimeTop3,
                          leaderboardData: creatorAllTimeData),
                    // Monthly Tab
                    if (selectedLeaderboard == 'Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: allTimeTop3, leaderboardData: allTimeData)
                    else if (selectedLeaderboard == 'Event Leaderboard')
                      buildLeaderboardTabView(
                          top3Data: eventAllTimeTop3,
                          leaderboardData: eventAllTimeData)
                    else
                      buildLeaderboardTabView(
                          top3Data: creatorAllTimeTop3,
                          leaderboardData: creatorAllTimeData),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
