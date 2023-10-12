import 'package:flutter/material.dart';
import 'package:google_home/src/home_feature/widget/card.dart';
import 'package:google_home/src/home_feature/widget/common.dart';

const _itemsGap = 11.0;
const _viewPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 24);

// TODO(payam): add theme and colors to the app
class HomeView extends StatelessWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18181E),
      body: Padding(
        padding: _viewPadding,
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 7,
                child: WetherCard(),
              ),
              const Gap.horizontal(_itemsGap),
              Expanded(
                flex: 18,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: LightCard(),
                          ),
                          Gap.horizontal(_itemsGap),
                          Expanded(
                            flex: 4,
                            child: PowerCard(),
                          ),
                        ],
                      ),
                    ),
                    const Gap.vertical(_itemsGap),
                    const Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: AirRelatedCard(
                              title: "AIR QUALITY",
                              value: "POOR",
                            ),
                          ),
                          Gap.horizontal(_itemsGap),
                          Expanded(
                            child: AirRelatedCard(
                              title: "TEMPERATURE",
                              value: "22.4°C",
                            ),
                          ),
                          Gap.horizontal(_itemsGap),
                          Expanded(
                            child: AirRelatedCard(
                              title: "HUMIDITY",
                              value: "43.3%",
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap.vertical(_itemsGap),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: SwitchCard(
                              enabled: true,
                              onChanged: (value) {},
                              title: "LIVING ROOM",
                              value: "TV",
                            ),
                          ),
                          const Gap.horizontal(_itemsGap),
                          Expanded(
                            child: SwitchCard(
                              enabled: false,
                              onChanged: (value) {},
                              title: "LIVING ROOM",
                              value: "STEREO",
                            ),
                          ),
                          const Gap.horizontal(_itemsGap),
                          Expanded(
                            child: SwitchCard(
                              enabled: false,
                              onChanged: (value) {},
                              title: "LIVING ROOM",
                              value: "THERMOSTAT",
                            ),
                          ),
                          const Gap.horizontal(_itemsGap),
                          Expanded(
                            child: SwitchCard(
                              enabled: false,
                              onChanged: (value) {},
                              title: "LIVING ROOM",
                              value: "FAN",
                            ),
                          ),
                        ],
                      ),
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
