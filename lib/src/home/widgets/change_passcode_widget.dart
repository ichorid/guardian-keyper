import '/src/core/di_container.dart';
import '/src/core/theme/theme.dart';
import '/src/core/widgets/common.dart';
import '/src/core/widgets/icon_of.dart';
import '/src/core/widgets/auth.dart';

class ChangePassCodeWidget extends StatelessWidget {
  const ChangePassCodeWidget({super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        leading: const IconOf.passcode(),
        title: const Text('Passcode'),
        subtitle: Text(
          'Change authentication passcode',
          style: textStyleSourceSansPro414Purple,
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: () {
          final diContainer = context.read<DIContainer>();
          screenLock(
            context: context,
            correctString: diContainer.boxSettings.passCode,
            canCancel: true,
            secretsConfig: secretsConfig,
            keyPadConfig: keyPadConfig,
            title: Padding(
                padding: paddingV32 + paddingH20,
                child: Text(
                  'Please enter your current passcode',
                  style: textStylePoppins620,
                  textAlign: TextAlign.center,
                )),
            onUnlocked: () {
              Navigator.of(context).pop();
              _createPincode(context);
            },
            onError: (_) async {
              ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
                text: 'Wrong passcode!',
                duration: const Duration(seconds: 2),
                isFloating: true,
                isError: true,
              ));
              await diContainer.platformService.vibrate();
            },
          );
        },
      );

  void _createPincode(BuildContext context) {
    final diContainer = context.read<DIContainer>();
    screenLockCreate(
      context: context,
      canCancel: true,
      digits: diContainer.globals.passCodeLength,
      keyPadConfig: keyPadConfig,
      secretsConfig: secretsConfig,
      config: screenLockConfig,
      title: Padding(
          padding: paddingV32 + paddingH20,
          child: Text(
            'Please create your new passcode',
            style: textStylePoppins620,
            textAlign: TextAlign.center,
          )),
      confirmTitle: Padding(
          padding: paddingV32 + paddingH20,
          child: Text(
            'Please repeate your new passcode',
            style: textStylePoppins620,
            textAlign: TextAlign.center,
          )),
      onConfirmed: (value) {
        diContainer.boxSettings.passCode = value;
        Navigator.of(context).pop();
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) => BottomSheetWidget(
            icon: const IconOf.secrets(isBig: true, bage: BageType.ok),
            titleString: 'Passcode changed',
            textString: 'Your login passcode was changed successfully.',
            footer: PrimaryButton(
              text: 'Done',
              onPressed: Navigator.of(context).pop,
            ),
          ),
        );
      },
      onError: (_) async {
        ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(
          text: 'Wrong passcode!',
          duration: const Duration(seconds: 2),
          isFloating: true,
          isError: true,
        ));
        await diContainer.platformService.vibrate();
      },
    );
  }
}
