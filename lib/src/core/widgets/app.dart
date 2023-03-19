import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/src/core/di.dart';
import '/src/core/routes.dart';
import '/src/core/theme/theme.dart';

import '/src/home/home_screen.dart';

import 'loader_widget.dart';

class App extends StatelessWidget {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(systemStyleDark);
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  const App({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
        title: 'Guardian Keyper',
        supportedLocales: const [Locale('en', '')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: themeLight,
        darkTheme: themeDark,
        themeMode: ThemeMode.dark,
        onGenerateRoute: onGenerateRoute,
        navigatorObservers: [SentryNavigatorObserver()],
        home: FutureBuilder<bool>(
          future: DI.init(),
          builder: (_, snapshot) =>
              snapshot.data == null ? const InitLoader() : const HomeScreen(),
        ),
      );
}