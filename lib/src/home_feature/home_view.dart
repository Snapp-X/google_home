import 'package:flutter/material.dart';
import 'package:google_home/src/core/styles/responsive.dart';
import 'package:google_home/src/home_feature/widget/card.dart';
import 'package:google_home/src/home_feature/widget/common.dart';

// TODO(payam): add theme and colors to the app
class HomeView extends StatelessWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: context.viewPadding,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 7,
                child: WetherCard(),
              ),
              Gap.horizontal(context.homeItemsGap),
              Expanded(
                flex: 18,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 6,
                            child: LightCard(),
                          ),
                          Gap.horizontal(context.homeItemsGap),
                          const Expanded(
                            flex: 4,
                            child: PowerCard(),
                          ),
                        ],
                      ),
                    ),
                    Gap.vertical(context.homeItemsGap),
                    const Expanded(
                      flex: 2,
                      child: AirRelatedRow(),
                    ),
                    Gap.vertical(context.homeItemsGap),
                    const Expanded(
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
