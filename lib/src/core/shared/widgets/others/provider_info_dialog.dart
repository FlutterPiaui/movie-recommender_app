import 'package:flutter/material.dart';

import '../../../../modules/movie_details/domain/entities/movie_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProviderInfoDialog extends StatelessWidget {
  final List<Providers> providersList;

  const ProviderInfoDialog({super.key, required this.providersList});

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text(
                str.availableOnPlatforms,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: providersList.length,
                itemBuilder: (context, index) {
                  final provider = providersList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${provider.logo}',
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          provider.providerName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey[700],
                  thickness: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
