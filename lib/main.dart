import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:franceinfo_app/src/app.dart';
import 'package:franceinfo_app/src/articles_listing/franceinfo_bloc.dart';
import 'package:franceinfo_app/src/settings/settings_controller.dart';
import 'package:franceinfo_app/src/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  LicenseRegistry.addLicense(() async* {
    final zenLicense = await rootBundle.loadString('fonts/OFL.txt');
    final merriLicense = await rootBundle.loadString('fonts/OFL_merri.txt');

    yield LicenseEntryWithLineBreaks(['google_fonts'], zenLicense);
    yield LicenseEntryWithLineBreaks(['google_fonts'], merriLicense);
  });

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  final bloc = FranceinfoBloc();

  runApp(
    FranceinfoApp(
      settingsController: settingsController,
      bloc: bloc,
    ),
  );
}