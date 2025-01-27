import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';
import 'package:guardian_keyper/ui/widgets/icon_of.dart';

import '../vault_show_presenter.dart';
import '../widgets/secrets_panel_list.dart';
import '../widgets/guardians_expansion_tile.dart';

class RestrictedVaultPage extends StatelessWidget {
  const RestrictedVaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vault = context.watch<VaultShowPresenter>().vault;
    return ListView(
      padding: paddingAll20,
      shrinkWrap: true,
      children: [
        // Title
        vault.isRestricted
            ? PageTitle(
                title: 'Restricted usage',
                subtitleSpans: [
                  TextSpan(
                    text: 'You are able to recover all Secrets belonging '
                        'to this Vault, however you can’t add new ones until ',
                    style: styleSourceSansPro416Purple,
                  ),
                  TextSpan(
                    text: '${vault.maxSize} out of ${vault.maxSize} '
                        'Guardians are added.',
                    style: styleSourceSansPro616Purple.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : PageTitle(
                title: 'Complete the recovery',
                subtitleSpans: [
                  TextSpan(
                    // TBD: i18n
                    text: 'Add ${vault.missed} more Guardian(s) ',
                    style: styleSourceSansPro616Purple.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'which were previously added to this '
                        'Vault via QR Code to complete the recovery.',
                    style: styleSourceSansPro416Purple,
                  ),
                ],
              ),
        // Action Button
        Padding(
          padding: paddingB32,
          child: PrimaryButton(
            text: 'Add a Guardian',
            onPressed: () => Navigator.of(context).pushNamed(routeVaultRestore),
          ),
        ),
        // Guardians
        const GuardiansExpansionTile(),
        // Secrets
        if (vault.hasSecrets) ...[
          Padding(
            padding: paddingV20,
            child: Text(
              'Secrets',
              style: stylePoppins620,
            ),
          ),
          if (vault.hasQuorum)
            const SecretsPanelList()
          else ...[
            Padding(
              padding: paddingB20,
              child: Text(
                'Complete the recovery to gain access to Vault’s secrets.',
                style: styleSourceSansPro416Purple,
              ),
            ),
            for (final secretId in vault.secrets.keys)
              Padding(
                padding: paddingV6,
                child: ListTile(
                  enabled: false,
                  leading: const IconOf.secret(),
                  title: Text(
                    secretId.name,
                    style: styleSourceSansPro614,
                  ),
                ),
              ),
          ],
        ],
      ],
    );
  }
}
