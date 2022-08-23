import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:franceinfo_app/src/articles_listing/articles_listing_view.dart';
import 'package:franceinfo_app/src/articles_listing/franceinfo_bloc.dart';
import 'package:franceinfo_app/src/settings/app_theme.dart' as app_theme;
import 'package:franceinfo_app/src/settings/settings_controller.dart';
import 'package:franceinfo_app/src/settings/settings_view.dart';

class FranceinfoApp extends StatelessWidget {
  final SettingsController settingsController;
  final FranceinfoBloc bloc;

  const FranceinfoApp({
    super.key,
    required this.settingsController,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, _) {
        return MaterialApp(
          restorationScopeId: 'franceinfo_app',
          title: 'Franceinfo',
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('fr'), // French, no country code
          ],
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: app_theme.lightTheme,
          darkTheme: app_theme.darkTheme,
          themeMode: settingsController.themeMode,
          initialRoute: ArticlesListingView.route,
          routes: {
            ArticlesListingView.route: (context) =>
                ArticlesListingView(bloc: bloc),
            SettingsView.route: (context) =>
                SettingsView(settingsController: settingsController),
          },
        );
      },
    );
  }
}