import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'package:guardian_keyper/ui/utils/utils.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';
import 'package:guardian_keyper/feature/auth/ui/dialogs/on_ask_auth_dialog.dart';

import '../vault_secret_recovery_presenter.dart';

class ShowSecretPage extends StatelessWidget {
  static const _mask = SvgPicture(AssetBytesLoader(
    'assets/images/secret_mask.svg.vec',
  ));

  static final _snackBar = buildSnackBar(
    text: 'Secret is copied to your clipboard.',
  );

  const ShowSecretPage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.watch<VaultSecretRecoveryPresenter>();
    return Column(
      children: [
        // Header
        const HeaderBar(
          caption: 'Secret Recovery',
          closeButton: HeaderBarCloseButton(),
        ),
        // Body
        Expanded(
          child: ListView(
            padding: paddingH20,
            children: [
              const PageTitle(
                title: 'Here’s your Secret',
                subtitle:
                    'Make sure your display is covered if you want to see your Secret.',
              ),
              // Secret
              Card(
                child: Padding(
                  padding: paddingAll20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 160,
                        padding: paddingB20,
                        child: presenter.isObfuscated
                            ? _mask
                            : Text(
                                presenter.secret,
                                style: styleSourceSansPro414Purple,
                              ),
                      ),
                      Row(children: [
                        Expanded(
                          child: presenter.isObfuscated
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (!presenter.tryShow()) {
                                      OnAskAuthDialog.show(
                                        context,
                                        onUnlocked: presenter.onUnlockedShow,
                                      );
                                    }
                                  },
                                  child: const Text('Show'),
                                )
                              : ElevatedButton(
                                  onPressed: presenter.onPressedHide,
                                  child: const Text('Hide'),
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: PrimaryButton(
                            text: 'Copy',
                            onPressed: () async {
                              final isOk = await presenter.tryCopy();
                              if (context.mounted) {
                                if (isOk) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(_snackBar);
                                } else {
                                  await OnAskAuthDialog.show(
                                    context,
                                    onUnlocked: () async {
                                      final isCopied =
                                          await presenter.onUnlockedCopy();
                                      if (isCopied && context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(_snackBar);
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
