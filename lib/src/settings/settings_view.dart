import 'package:flutter/material.dart';
import 'package:franceinfo_app/src/settings/settings_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController settingsController;

  const SettingsView({super.key, required this.settingsController});

  static const route = '/settings';

  static const appLegalese =
      'Cette application est développée par Quentin Eppe avec Flutter et le flux RSS officiel de Franceinfo.';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Paramètres'),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('Thème système'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Thème clair'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Thème sombre'),
                      ),
                    ],
                    value: settingsController.themeMode,
                    onChanged: settingsController.updateThemeMode,
                  ),
                ),
                const AboutListTile(
                  icon: Icon(Icons.info_outline),
                  applicationLegalese: appLegalese,
                  applicationVersion: '1.0.0',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}