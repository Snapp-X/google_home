import 'package:flutter/material.dart';
import 'package:google_home/src/home_feature/home_widgets.dart';

const _itemsGap = 11.0;
const _viewPadding = EdgeInsets.symmetric(horizontal: 32, vertical: 24);

// TODO(payam): add theme and colors to the app
class HomeView extends StatelessWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF18181E),
      body: Padding(
        padding: _viewPadding,
        child: LayoutBuilder(builder: (context, constraints) {
          print(constraints);

          return const Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: HomeContainer(

                    height: double.infinity,
                    colorMode: ColorMode.gradient,
                    borderRadius: 20,
                  ),
                ),
                Gap.horizontal(_itemsGap),
                Expanded(
                  flex: 18,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 49,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                    borderRadius: 20,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              flex: 4,
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                    borderRadius: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap.vertical(_itemsGap),
                      Expanded(
                        flex: 20,
                        child: Row(
                          children: [
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap.vertical(_itemsGap),
                      Expanded(
                        flex: 31,
                        child: Row(
                          children: [
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
                              ),
                            ),
                            Gap.horizontal(_itemsGap),
                            Expanded(
                              child: HomeContainer(
                                colorMode: ColorMode.solid,
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
          );
        }),
      ),
    );
  }
}
