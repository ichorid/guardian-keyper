import 'package:flutter_svg/flutter_svg.dart';

import '/src/core/theme/theme.dart';
import '/src/core/widgets/misc.dart';

import '../intro_controller.dart';

class IntrosPage extends StatefulWidget {
  const IntrosPage({super.key});

  @override
  State<IntrosPage> createState() => _IntrosPageState();
}

class _IntrosPageState extends State<IntrosPage> {
  static const _titles = [
    'Welcome to Guardian Keyper',
    'Decentralized',
    'Secure',
    'Never forget again',
  ];
  static const _subtitles = [
    'Guardian Keyper is a secure way to store and recover secrets, such as seed'
        ' phrases. With Guardian Keyper, your Web3 assets are safe.',
    'Guardian Keyper splits a secret into a number of encrypted shards. Shards'
        ' are then stored on devices owned by “Guardians”, persons you trust.',
    'Each Shard is protected by state-of-the-art encryption algorithms and'
        ' can’t be reversed into a seed phrase without approval of Guardians.',
    'You can restore your seed phrase any time with the help of Guardians.'
        ' Even in case you’ve lost access to your device.',
  ];
  int _step = 0;

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < -5) {
            if (_step == _titles.length - 1) {
              context.read<IntroController>().nextScreen();
            } else if (_step < _titles.length - 1) {
              setState(() => _step++);
            }
          } else if (details.velocity.pixelsPerSecond.dx > 5 && _step > 0) {
            setState(() => _step--);
          }
        },
        child: Padding(
          padding: paddingAll20,
          child: Column(
            children: [
              ListView(
                primary: true,
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: paddingBottom32,
                    child: SvgPicture.asset(
                      'assets/images/intro_${_step + 1}.svg',
                    ),
                  ),
                  Padding(
                    padding: paddingBottom12,
                    child: Text(
                      _titles[_step],
                      style: textStylePoppins620.copyWith(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: paddingBottom20,
                    child: Text(
                      _subtitles[_step],
                      style: textStyleSourceSansPro416,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: context.read<IntroController>().nextScreen,
                        child: Text('Skip', style: textStylePoppins616),
                      ),
                      DotBar(
                        count: 4,
                        active: _step,
                        activeColor: clBlue,
                        passiveColor: clIndigo600,
                      ),
                      TextButton(
                        onPressed: () => _step == (_titles.length - 1)
                            ? context.read<IntroController>().nextScreen()
                            : setState(() => _step++),
                        child: Text('Next', style: textStylePoppins616),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
