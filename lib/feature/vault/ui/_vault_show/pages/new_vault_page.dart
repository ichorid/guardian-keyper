import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';

import '../vault_show_presenter.dart';
import '../../widgets/guardian_self_list_tile.dart';
import '../widgets/guardian_with_ping_tile.dart';

class NewVaultPage extends StatelessWidget {
  const NewVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vault = context.watch<VaultShowPresenter>().vault;
    return ListView(
      padding: paddingAll20,
      shrinkWrap: true,
      children: [
        PageTitle(
          title: 'Add more Guardians',
          subtitleSpans: [
            TextSpan(
              text: 'Add ${vault.maxSize - vault.size} more Guardians ',
              style: styleSourceSansPro616Purple.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'to enable your Vault and secure your Secret.',
              style: styleSourceSansPro416Purple,
            ),
          ],
        ),
        Padding(
          padding: paddingB32,
          child: PrimaryButton(
            text: 'Add a Guardian',
            onPressed: () => Navigator.of(context).pushNamed(
              routeVaultGuardianAdd,
              arguments: vault.id,
            ),
          ),
        ),
        for (final guardian in vault.guardians.keys)
          Padding(
            padding: paddingV6,
            child: guardian == vault.ownerId
                ? const GuardianSelfListTile()
                : GuardianWithPingTile(guardian: guardian),
          ),
      ],
    );
  }
}
