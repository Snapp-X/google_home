import 'package:flutter/material.dart';
import 'package:google_home/src/home_feature/widget/card.dart';
import 'package:google_home/src/home_feature/widget/common.dart';

const homeItemsGap = 11.0;
const _viewPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 24);

// TODO(payam): add theme and colors to the app
class HomeView extends StatelessWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF18181E),
      body: Padding(
        padding: _viewPadding,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: WetherCard(),
              ),
              Gap.horizontal(homeItemsGap),
              Expanded(
                flex: 18,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: LightCard(),
                          ),
                          Gap.horizontal(homeItemsGap),
                          Expanded(
                            flex: 4,
                            child: PowerCard(),
                          ),
                        ],
                      ),
                    ),
                    Gap.vertical(homeItemsGap),
                    Expanded(
                      flex: 2,
                      child: AirRelatedRow(),
                    ),
                    Gap.vertical(homeItemsGap),
                    Expanded(
                      flex: 3,
                      child: SwitchesRow(),
                    ),
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
