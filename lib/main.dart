import 'package:flutter/material.dart';
import 'package:amplitude_flutter/amplitude.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'src/app.dart';
import 'src/core/theme/theme.dart';
import 'src/core/utils/init_os.dart';
import 'src/core/model/core_model.dart';
import 'src/core/utils/init_dependencies.dart';
import 'src/core/service/p2p_network_service.dart';
import 'src/core/service/platform_service.dart';
import 'src/core/service/analytics_service.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) => options
      ..dsn = const String.fromEnvironment('SENTRY_URL')
      ..tracesSampleRate = 1.0,
    appRunner: () async {
      FlutterNativeSplash.preserve(
        widgetsBinding: await init(statusBarColor: clIndigo900),
      );
      runApp(App(
          diContainer: await initDependencies(
        globals: const Globals(
          bsAddressV4: String.fromEnvironment('BS_V4'),
          bsAddressV6: String.fromEnvironment('BS_V6'),
          bsPeerId: String.fromEnvironment('BS_ID'),
          bsPort: int.fromEnvironment('BS_PORT'),
        ),
        networkService: P2PNetworkService()
          ..router.maxForwardsCount = 3
          ..router.maxStoredHeaders = 10,
        platformService: PlatformService(
          hasBiometrics: await PlatformService.checkIfHasBiometrics(),
        ),
        analyticsService: AnalyticsService(
          logEvent: (await _getAmplitude()).logEvent,
        ),
      )));
      FlutterNativeSplash.remove();
    },
  );
}

Future<Amplitude> _getAmplitude() async {
  final amplitude = Amplitude.getInstance();
  await amplitude.init(const String.fromEnvironment('AMPLITUDE_KEY'));
  await amplitude.trackingSessionEvents(true);
  // Enable COPPA privacy guard.
  // This is useful when you choose not to report sensitive user information.
  await amplitude.enableCoppaControl();
  return amplitude;
}
