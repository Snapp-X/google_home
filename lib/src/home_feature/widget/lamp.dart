import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_home/src/home_feature/home_controller.dart';
import 'package:rive/rive.dart';

final lampRiveProvider = FutureProvider<RiveFile>((ref) async {
  final data = await rootBundle.load('assets/rive/lamp2.riv');

  final riveFile = RiveFile.import(data);

  return riveFile;
});

class Lamp extends ConsumerStatefulWidget {
  const Lamp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LampState();
}

class _LampState extends ConsumerState<Lamp> {
  SMINumber? colourInput;

  @override
  Widget build(BuildContext context) {
    final lampFile = ref.watch(lampRiveProvider);

    ref.listen(
      homeValuesProvider.select((value) => value.lightBulbState),
      (previous, next) {
        if (!next.isOn) {
          colourInput?.value = 0;

          return;
        } else if (next.isOn && next.color == 0) {
          colourInput?.value = 1;

          return;
        }

        colourInput?.value = next.color.toDouble();
      },
    );

    return lampFile.maybeWhen(
      data: (data) {
        return RiveAnimation.direct(
          data,
          onInit: (art) {
            final controller =
                StateMachineController.fromArtboard(art, 'Colour Switch')
                    as StateMachineController;

            controller.isActive = true;

            art.addController(controller);

            colourInput = controller.findSMI('Colour') as SMINumber;
          },
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}
