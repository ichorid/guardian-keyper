import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/widgets/common.dart';
import 'package:guardian_keyper/ui/widgets/icon_of.dart';

import '../intro_presenter.dart';

class SetDeviceNamePage extends StatelessWidget {
  const SetDeviceNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final presenter = context.read<IntroPresenter>();
    return ListView(
      padding: paddingAll20,
      children: [
        const Padding(
          padding: paddingV20,
          child: IconOf.app(isBig: true),
        ),
        Padding(
          padding: paddingV20,
          child: Text(
            'Create your Guardian name',
            textAlign: TextAlign.center,
            style: stylePoppins620,
          ),
        ),
        Padding(
            padding: paddingV20,
            child: TextFormField(
              autofocus: true,
              initialValue: presenter.deviceName,
              onChanged: (value) => presenter.deviceName = value,
              keyboardType: TextInputType.text,
              maxLength: maxNameLength,
              decoration: const InputDecoration(
                labelText: ' Guardian name ',
                helperText: 'Minimum $minNameLength characters',
              ),
            )),
        Padding(
          padding: paddingV20,
          child: Consumer<IntroPresenter>(
            builder: (_, presenter, ___) => PrimaryButton(
              text: 'Proceed',
              onPressed:
                  presenter.canSaveName ? presenter.saveDeviceName : null,
            ),
          ),
        ),
      ],
    );
  }
}
