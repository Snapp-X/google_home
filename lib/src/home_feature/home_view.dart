import 'package:flutter/material.dart';
import 'package:google_home/src/home_feature/home_widgets.dart';

// TODO(payam): add theme and colors to the app
class HomeView extends StatelessWidget {
  static const routeName = '/';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF18181E),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeContainer(
              width: 100,
              height: 100,
              colorMode: ColorMode.gradient,
            ),
            SizedBox(height: 20),
            HomeContainer(
              width: 100,
              height: 100,
              colorMode: ColorMode.solid,
            ),
          ],
        ),
      ),
    );
  }
}
