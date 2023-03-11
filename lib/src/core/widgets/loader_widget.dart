import 'package:flutter/material.dart';

import '/src/core/consts.dart';
import '/src/core/di_container.dart';
import '/src/core/widgets/icon_of.dart';
import '/src/auth/auth_controller.dart';
import '/src/settings/settings_controller.dart';
import '/src/guardian/guardian_controller.dart';
import '/src/core/service/p2p_network_service.dart';

class LoaderWidget extends StatefulWidget {
  const LoaderWidget({super.key});

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget>
    with TickerProviderStateMixin {
  late final _logoSize = MediaQuery.of(context).size.width / 3;

  late final _backgroundColor = Theme.of(context).scaffoldBackgroundColor;

  late final _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  @override
  void initState() {
    super.initState();
    Future.microtask(_init);
  }

  @override
  Widget build(final BuildContext context) => Container(
        alignment: Alignment.center,
        color: _backgroundColor,
        child: RotationTransition(
          turns: _controller,
          child: IconOf.app(size: _logoSize),
        ),
      );

  Future<void> _init() async {
    final diContainer = await GetIt.I<DIContainer>().init();
    GetIt.I.registerSingleton<P2PNetworkService>(diContainer.networkService);
    final settingsCubit = SettingsController();
    await settingsCubit.init();
    GetIt.I.registerSingleton<SettingsController>(settingsCubit);

    _controller.stop();
    _controller.dispose();
    if (mounted && settingsCubit.state.passCode.isNotEmpty) {
      await GetIt.I<AuthController>().checkPassCode(
        context: context,
        canCancel: false,
        onUnlock: Navigator.of(context).pop,
      );
    }
    if (settingsCubit.state.isBootstrapEnabled) {
      diContainer.networkService.addBootstrapServer(
        peerId: Envs.bsPeerId,
        ipV4: Envs.bsAddressV4,
        ipV6: Envs.bsAddressV6,
        port: Envs.bsPort,
      );
    }
    await GetIt.I<GuardianController>().pruneMessages();
    await diContainer.networkService.start();
    if (mounted) Navigator.of(context).pushReplacementNamed(routeHome);
  }
}