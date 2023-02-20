import '/src/core/di_container.dart';
import '/src/core/theme/theme.dart';
import '/src/core/widgets/common.dart';
import '/src/core/widgets/icon_of.dart';

import '../settings_view.dart';

class ChangePassCodeListTile extends StatelessWidget {
  const ChangePassCodeListTile({super.key});

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
          context.read<DIContainer>().authService.changePassCode(
                context: context,
                onExit: () => Navigator.of(context)
                    .popUntil(ModalRoute.withName(SettingsView.routeName)),
              );
        },
      );
}