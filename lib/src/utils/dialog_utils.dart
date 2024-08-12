import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/provider_info_dialog.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/entities/movie_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DialogUtils {
  static Future<void> _openUpdateApp() async {
    //Update link after deploy
    final url = Platform.isIOS
        ? 'https://www.apple.com/br/store'
        : 'https://play.google.com/store/games?hl=pt_BR';

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static void showInAppUpdateDialog(
      {required BuildContext context, required bool skipInstall}) {
    final str = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog.adaptive(
          titlePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Image.asset('assets/images/logo_app_gemini.png', height: 60),
              Expanded(
                child: Text(
                  str.newVersionAvailable,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          actions: [
            if (skipInstall)
              TextButton(
                onPressed: () => context.pop(),
                child: Text(str.skip, style: theme.textTheme.bodySmall),
              ),
            TextButton(
              onPressed: () async => await _openUpdateApp(),
              child: Text(
                str.install,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showProviderInfoDialog({
    required BuildContext context,
    required List<Providers> providersList,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProviderInfoDialog(providersList: providersList);
      },
    );
  }
}
