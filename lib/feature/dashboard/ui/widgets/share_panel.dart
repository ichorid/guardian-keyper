import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';

import '../dashboard_presenter.dart';

class SharePanel extends StatelessWidget {
  const SharePanel({super.key});

  @override
  Widget build(BuildContext context) => Container(
        decoration: boxDecoration,
        padding: paddingAll20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Become a Guardian', style: stylePoppins616),
                      Padding(
                        padding: paddingT12,
                        child: Text(
                          'Share your QR code to join a Vault',
                          style: styleSourceSansPro416Purple,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.qr_code_2_rounded,
                  size: 60,
                  color: clWhite,
                ),
              ],
            ),
            Padding(
              padding: paddingT20,
              child: ElevatedButton(
                child: const Text('Generate QR Code'),
                onPressed: () async {
                  final message = await context
                      .read<DashboardPresenter>()
                      .createJoinVaultCode();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(
                      routeQrCodeShow,
                      arguments: (
                        qrCode: message.toBase64url(),
                        caption: 'Become a Guardian',
                        subtitle:
                            'This is a one-time for joining a Vault as a Guardian. '
                            'You can either show it directly as a QR Code '
                            'or Share as a Text via any messenger.',
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: paddingT20,
              child: OutlinedButton(
                onPressed: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  await context.read<DashboardPresenter>().share(
                        'https://myguardian.network/app-router',
                        sharePositionOrigin:
                            box!.localToGlobal(Offset.zero) & box.size,
                      );
                },
                child: const Text('Share the App link'),
              ),
            ),
          ],
        ),
      );
}
